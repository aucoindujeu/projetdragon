Player = Object:extend()

function Player:new(x, y, speed, location, maxHealth, xp)
    self.rect = createRect(x, y, 20, 30, "dynamic", 1)
    self.rect.body:setFixedRotation(true)
    self.rect.fixture:setUserData("Player")
    self.rect.fixture:setMask(2)
    self.location = location
    self.speed = speed

    self.reading = ""
    self.readingTimer = 0

    self.dir = "down"

    self.boomerang = {
        rect = nil,
        available = true,
        angle = 0,
        timer = 0,
        thrown = false,
        going = true,
        returning = false,
        vx = 0,
        vy = 0,
        speed = 200,
        image = love.graphics.newImage("images/banana.png")
    }

    self.AnimationWalkTimer = 1
    self.AnimationAttackTimer = 1

    self.AnimationWalkDown = {}
    for i=0, 3 do
        table.insert(self.AnimationWalkDown, love.graphics.newImage("images/animations/walk_down_" .. i .. ".png"))
    end

    self.AnimationWalkUp = {}
    for i=0, 3 do
        table.insert(self.AnimationWalkUp, love.graphics.newImage("images/animations/walk_up_" .. i .. ".png"))
    end

    self.AnimationWalkRight = {}
    for i=0, 3 do
        table.insert(self.AnimationWalkRight, love.graphics.newImage("images/animations/walk_right_" .. i .. ".png"))
    end


    self.AnimationAttackDown = {}
    for i=1, 4 do
        table.insert(self.AnimationAttackDown, love.graphics.newImage("images/animations/attack_down_" .. i .. ".png"))
    end

    self.AnimationAttackUp = {}
    for i=0, 3 do
        table.insert(self.AnimationAttackUp, love.graphics.newImage("images/animations/attack_up_" .. i .. ".png"))
    end

    self.AnimationAttackRight = {}
    for i=0, 3 do
        table.insert(self.AnimationAttackRight, love.graphics.newImage("images/animations/attack_right_" .. i .. ".png"))
    end

    self.attacking = false 
    self.walking = false

    self.maxHealth = maxHealth
    self.health = self.maxHealth

    self.heartFull = love.graphics.newImage("images/heartFull.png")
    self.heartEmpty = love.graphics.newImage("images/heartEmpty.png")

    self.swordLength = 100
    self.attackRect = createRect(-1000, -1000, self.swordLength, self.swordLength, "static", 1)
    self.attackRect.fixture:setUserData("Sword")
    self.attackRect.fixture:setCategory(2)

    self.xp = xp
end

function Player:update(dt)
    self.AnimationWalkTimer = self.AnimationWalkTimer + dt * 6
    if self.AnimationWalkTimer >= 5 then
        self.AnimationWalkTimer = 1
    end

    if not (self.reading == "") then
        self.readingTimer = self.readingTimer + dt
        if self.readingTimer > 3 then
            self.readingTimer = 0
            self.reading = ""
        end
    end

    if self.attacking then
        self.AnimationAttackTimer = self.AnimationAttackTimer + dt * 5
        if self.AnimationAttackTimer >= 4 then
            self.attacking = false
            self.AnimationAttackTimer = 1
            self.attackRect.body:setX(-1000)
            self.attackRect.body:setY(-1000)
        end
    end

    vx = 0
    vy = 0

    self.walking = false

    if numJoysticks < 1 then
        if love.keyboard.isDown("space") then
            self:attack()
        
        elseif love.keyboard.isDown("c") and not self.boomerang.thrown then
            self:boomerangThrow()

        elseif not self.attacking then
            if love.keyboard.isDown("left") then
                self:left()
            elseif love.keyboard.isDown("right") then
                self:right()
            end

            if love.keyboard.isDown("up") then
                self:up()
            elseif love.keyboard.isDown("down") then
                self:down()
            end
        end
    else
        if joysticks[1]:isDown(1) then
            self:attack()

        elseif not self.attacking then
            if joysticks[1]:getAxis(1) < -0.1 then
                self:left()
            elseif joysticks[1]:getAxis(1) > 0.1 then
                self:right()
            end

            if joysticks[1]:getAxis(2) < -0.1 then
                self:up()
            elseif joysticks[1]:getAxis(2) > 0.1 then
                self:down()
            end
        end
    end


    if self.boomerang.thrown then
        self.boomerang.angle = self.boomerang.angle + dt * 5
        self.boomerang.timer = self.boomerang.timer + dt
        if self.boomerang.timer > 1 then
            self.boomerang.going = false
            self.boomerang.returning = true

            self.boomerang.vx, self.boomerang.vy = lume.vector(lume.angle(self.boomerang.rect.body:getX(), self.boomerang.rect.body:getY(), self.rect.body:getX(), self.rect.body:getY()), 
                                                    self.boomerang.speed)
            
            if lume.distance(self.boomerang.rect.body:getX(), self.boomerang.rect.body:getY(), self.rect.body:getX(), self.rect.body:getY()) < 30 then
                self.boomerang.thrown = false
                self.boomerang.returning = false
                self.boomerang.timer = 0
                self.boomerang.vx = 0
                self.boomerang.vy = 0
            end
        end

        self.boomerang.rect.body:setLinearVelocity(self.boomerang.vx, self.boomerang.vy)
    end


    self.rect.body:setLinearVelocity(vx, vy)

    if self.health <= 0 then
        love.load()
    end
end

function Player:draw()
    local x = self.rect.body:getX() - self.rect.width / 2
    local y = self.rect.body:getY() - self.rect.height / 2
    if self.walking then
        if self.dir == "down" then
            love.graphics.draw(self.AnimationWalkDown[math.floor(self.AnimationWalkTimer)], x, y, 0,
                                self.rect.width / self.AnimationWalkDown[1]:getWidth(),
                                self.rect.height / self.AnimationWalkDown[1]:getHeight())

        elseif self.dir == "up" then
            love.graphics.draw(self.AnimationWalkUp[math.floor(self.AnimationWalkTimer)], x, y, 0,
                                self.rect.width / self.AnimationWalkUp[math.floor(self.AnimationWalkTimer)]:getWidth(),
                                self.rect.height / self.AnimationWalkUp[math.floor(self.AnimationWalkTimer)]:getHeight())

        elseif self.dir == "right" then
            love.graphics.draw(self.AnimationWalkRight[math.floor(self.AnimationWalkTimer)], x, y, 0,
                                self.rect.width / self.AnimationWalkRight[math.floor(self.AnimationWalkTimer)]:getWidth(),
                                self.rect.height / self.AnimationWalkRight[math.floor(self.AnimationWalkTimer)]:getHeight())

        elseif self.dir == "left" then
            love.graphics.draw(self.AnimationWalkRight[math.floor(self.AnimationWalkTimer)], x + self.rect.width, y, 0,
                                -(self.rect.width / self.AnimationWalkRight[math.floor(self.AnimationWalkTimer)]:getWidth()),
                                self.rect.height / self.AnimationWalkRight[math.floor(self.AnimationWalkTimer)]:getHeight())
        end


    elseif self.attacking then
        if self.dir == "down" then
            love.graphics.draw(self.AnimationAttackDown[math.floor(self.AnimationAttackTimer)], x, y, 0,
                                self.rect.width / self.AnimationAttackDown[math.floor(self.AnimationAttackTimer)]:getWidth(),
                                self.rect.height / self.AnimationAttackDown[math.floor(self.AnimationAttackTimer)]:getHeight())
        
        elseif self.dir == "up" then
            love.graphics.draw(self.AnimationAttackUp[math.floor(self.AnimationAttackTimer)], x, y, 0,
                                self.rect.width / self.AnimationAttackUp[math.floor(self.AnimationAttackTimer)]:getWidth(),
                                self.rect.height / self.AnimationAttackUp[math.floor(self.AnimationAttackTimer)]:getHeight())
        
        elseif self.dir == "right" then
            love.graphics.draw(self.AnimationAttackRight[math.floor(self.AnimationAttackTimer)], x, y, 0,
                                self.rect.width / self.AnimationAttackRight[math.floor(self.AnimationAttackTimer)]:getWidth(),
                                self.rect.height / self.AnimationAttackRight[math.floor(self.AnimationAttackTimer)]:getHeight())
        
        elseif self.dir == "left" then
            love.graphics.draw(self.AnimationAttackRight[math.floor(self.AnimationAttackTimer)], x + self.rect.width, y, 0,
                                -(self.rect.width / self.AnimationAttackRight[math.floor(self.AnimationAttackTimer)]:getWidth()),
                                self.rect.height / self.AnimationAttackRight[math.floor(self.AnimationAttackTimer)]:getHeight())
        end


    else
        if self.dir == "down" then
            love.graphics.draw(self.AnimationWalkDown[1], x, y, 0,
                                self.rect.width / self.AnimationWalkDown[1]:getWidth(),
                                self.rect.height / self.AnimationWalkDown[1]:getHeight())
        end

        if self.dir == "up" then
            love.graphics.draw(self.AnimationWalkUp[1], x, y, 0,
                                self.rect.width / self.AnimationWalkUp[1]:getWidth(),
                                self.rect.height / self.AnimationWalkUp[1]:getHeight())
        end

        if self.dir == "right" then
            love.graphics.draw(self.AnimationWalkRight[1], x, y, 0,
                                self.rect.width / self.AnimationWalkRight[1]:getWidth(),
                                self.rect.height / self.AnimationWalkRight[1]:getHeight())
        end

        if self.dir == "left" then
            love.graphics.draw(self.AnimationWalkRight[1], x + self.rect.width, y, 0,
                                -(self.rect.width / self.AnimationWalkRight[1]:getWidth()),
                                self.rect.height / self.AnimationWalkRight[1]:getHeight())
        end
    end

    if self.boomerang.thrown then
        love.graphics.draw(self.boomerang.image, self.boomerang.rect.body:getX(), self.boomerang.rect.body:getY(),
                            self.boomerang.angle,
                            self.boomerang.rect.width / self.boomerang.image:getWidth(),
                            self.boomerang.rect.height / self.boomerang.image:getHeight(),
                            self.boomerang.rect.width / 2,
                            self.boomerang.rect.height / 2)
    end
end

function Player:left()
    vx = -self.speed
    self.walking = true
    self.dir = "left"
end

function Player:right()
    vx = self.speed
    self.walking = true
    self.dir = "right"
end

function Player:up()
    vy = -self.speed
    self.walking = true
    self.dir = "up"
end

function Player:down()
    vy = self.speed
    self.walking = true
    self.dir = "down"
end

function Player:boomerangThrow()
    self.boomerang.thrown = true
    self.boomerang.going = true

    if self.dir == "down" then
        self.boomerang.vy = self.boomerang.speed
        self.boomerang.rect = createRect(self.rect.body:getX() + self.rect.width / 2, self.rect.body:getY() + self.rect.height, 10, 10, "dynamic", 1)
    elseif self.dir == "up" then
        self.boomerang.vy = -self.boomerang.speed
        self.boomerang.rect = createRect(self.rect.body:getX() + self.rect.width / 2, self.rect.body:getY(), 10, 10, "dynamic", 1)
    elseif self.dir == "left" then
        self.boomerang.vx = -self.boomerang.speed
        self.boomerang.rect = createRect(self.rect.body:getX(), self.rect.body:getY() + self.rect.height / 2, 10, 10, "dynamic", 1)
    elseif self.dir == "right" then
        self.boomerang.vx = self.boomerang.speed
        self.boomerang.rect = createRect(self.rect.body:getX() + self.rect.width, self.rect.body:getY() + self.rect.height / 2, 10, 10, "dynamic", 1)
    end

    self.boomerang.rect.fixture:setUserData("boomerang")
end

function Player:attack()
    self.attacking = true
    if self.dir == "down" then
        self.attackRect.body:setX(self.rect.body:getX())
        self.attackRect.body:setY(self.rect.body:getY() + self.rect.height)
    elseif self.dir == "up" then
        self.attackRect.body:setX(self.rect.body:getX())
        self.attackRect.body:setY(self.rect.body:getY() - self.rect.height)
    elseif self.dir == "right" then
        self.attackRect.body:setX(self.rect.body:getX() + self.rect.width)
        self.attackRect.body:setY(self.rect.body:getY())
    elseif self.dir == "left" then
        self.attackRect.body:setX(self.rect.body:getX() - self.rect.width)
        self.attackRect.body:setY(self.rect.body:getY())
    end
end

function Player:drawHearts(x, y)
    local size = 3
    for i=1, self.maxHealth do
        if self.health >= i then
            love.graphics.draw(self.heartFull, x + (i - 1) * self.heartFull:getWidth() * size, y, 0, size, size)
        else
            love.graphics.draw(self.heartEmpty, x + (i - 1) * self.heartFull:getWidth() * size, y, 0, size, size)
        end
    end

    love.graphics.print("xp: " .. self.xp, font, 0, 100)

    -- TODO: add nice graphics
    love.graphics.print(self.reading, font, 200, 100)
end

function Player:heal(amount)
    for i=1,amount do
        if self.health < self.maxHealth then
            self.health = self.health + 1
        end
    end
end

function Player:gainHeart(amount)
    self.maxHealth = self.maxHealth + amount
    self.health = self.maxHealth
end