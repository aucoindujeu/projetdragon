Player = Object:extend()

function Player:new(x, y, speed)
    self.rect = createRect(x, y, 20, 30, "dynamic", 1)
    self.speed = speed

    self.dir = "down"

    self.AnimationWalkTimer = 1

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

    self.walking = false
end

function Player:update(dt)
    self.AnimationWalkTimer = self.AnimationWalkTimer + dt * 6
    if self.AnimationWalkTimer >= 5 then
        self.AnimationWalkTimer = 1
    end

    vx = 0
    vy = 0

    self.walking = false

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

    self.rect.body:setLinearVelocity(vx, vy)
end

function Player:draw()
    -- love.graphics.rectangle("fill",
    --                         self.rect.body:getX(), 
    --                         self.rect.body:getX(),
    --                         self.rect.width,
    --                         self.rect.height)
    if self.walking then
        if self.dir == "down" then
            love.graphics.draw(self.AnimationWalkDown[math.floor(self.AnimationWalkTimer)], self.rect.body:getX(), self.rect.body:getY(), 0,
                                self.rect.width / self.AnimationWalkDown[1]:getWidth(),
                                self.rect.height / self.AnimationWalkDown[1]:getHeight())

        elseif self.dir == "up" then
            love.graphics.draw(self.AnimationWalkUp[math.floor(self.AnimationWalkTimer)], self.rect.body:getX(), self.rect.body:getY(), 0,
                                self.rect.width / self.AnimationWalkUp[1]:getWidth(),
                                self.rect.height / self.AnimationWalkUp[1]:getHeight())

        elseif self.dir == "right" then
            love.graphics.draw(self.AnimationWalkRight[math.floor(self.AnimationWalkTimer)], self.rect.body:getX(), self.rect.body:getY(), 0,
                                self.rect.width / self.AnimationWalkRight[1]:getWidth(),
                                self.rect.height / self.AnimationWalkRight[1]:getHeight())

        elseif self.dir == "left" then
            love.graphics.draw(self.AnimationWalkRight[math.floor(self.AnimationWalkTimer)], self.rect.body:getX() + self.rect.width, self.rect.body:getY(), 0,
                                -(self.rect.width / self.AnimationWalkRight[1]:getWidth()),
                                self.rect.height / self.AnimationWalkRight[1]:getHeight())
        end
    else
        if self.dir == "down" then
            love.graphics.draw(self.AnimationWalkDown[1], self.rect.body:getX(), self.rect.body:getY(), 0,
                                self.rect.width / self.AnimationWalkDown[1]:getWidth(),
                                self.rect.height / self.AnimationWalkDown[1]:getHeight())
        end

        if self.dir == "up" then
            love.graphics.draw(self.AnimationWalkUp[1], self.rect.body:getX(), self.rect.body:getY(), 0,
                                self.rect.width / self.AnimationWalkUp[1]:getWidth(),
                                self.rect.height / self.AnimationWalkUp[1]:getHeight())
        end

        if self.dir == "right" then
            love.graphics.draw(self.AnimationWalkRight[1], self.rect.body:getX(), self.rect.body:getY(), 0,
                                self.rect.width / self.AnimationWalkRight[1]:getWidth(),
                                self.rect.height / self.AnimationWalkRight[1]:getHeight())
        end

        if self.dir == "left" then
            love.graphics.draw(self.AnimationWalkRight[1], self.rect.body:getX() + self.rect.width, self.rect.body:getY(), 0,
                                -(self.rect.width / self.AnimationWalkRight[1]:getWidth()),
                                self.rect.height / self.AnimationWalkRight[1]:getHeight())
        end
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