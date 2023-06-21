Enemy = Object:extend()

Enemy.AnimationSleep = {}
for i=0, 3 do
    table.insert(Enemy.AnimationSleep, love.graphics.newImage("images/animations/logSleep" .. i .. ".png"))
end

Enemy.AnimationWalkDown = {}
for i=0, 3 do
    table.insert(Enemy.AnimationWalkDown, love.graphics.newImage("images/animations/logWalkDown" .. i .. ".png"))
end

Enemy.AnimationWalkUp = {}
for i=0, 3 do
    table.insert(Enemy.AnimationWalkUp, love.graphics.newImage("images/animations/logWalkUp" .. i .. ".png"))
end

Enemy.AnimationWalkRight = {}
for i=0, 3 do
    table.insert(Enemy.AnimationWalkRight, love.graphics.newImage("images/animations/logWalkRight" .. i .. ".png"))
end

function Enemy:new(x, y)
    self.rect = createRect(x, y, 20, 20, "dynamic", 1)
    self.rect.body:setFixedRotation(true)
    self.rect.fixture:setUserData("Enemy")
    -- self.rect.fixture.parent = self

    self.health = 3
    self.xp = 10

    enemiesHealth[self.rect.fixture] = self.health

    self.AnimationTimer = 1

    self.sleep = true
    self.speed = 50

    self.dir = "down"

    self.dead = false
end

function Enemy:update(dt)
    self.AnimationTimer = self.AnimationTimer + dt * 5
    if self.AnimationTimer >= 5 then
        self.AnimationTimer = 1
    end

    local vx = 0
    local vy = 0
    self.sleep = true
    if lume.distance(player.rect.body:getX(), player.rect.body:getY(), self.rect.body:getX(), self.rect.body:getY()) < 200 then
        self.sleep = false

        vx, vy = lume.vector(lume.angle(self.rect.body:getX(), self.rect.body:getY(), player.rect.body:getX(), player.rect.body:getY()), self.speed)

        if vx < -10 then
            self.dir = "left"
        elseif vx > 10 then
            self.dir = "right"
        elseif vy < 0 then
            self.dir = "up"
        else
            self.dir = "down"
        end
    end

    self.rect.body:setLinearVelocity(vx, vy)

    if enemiesHealth[self.rect.fixture] <= 0 then
        self.dead = true
    end
end

function Enemy:draw()
    local x = self.rect.body:getX() - self.rect.width / 2
    local y = self.rect.body:getY() - self.rect.height / 2
    if self.sleep then
        love.graphics.draw(self.AnimationSleep[math.floor(self.AnimationTimer)], x, y, 0,
                            self.rect.width / self.AnimationSleep[math.floor(self.AnimationTimer)]:getWidth(),
                            self.rect.height / self.AnimationSleep[math.floor(self.AnimationTimer)]:getHeight())
    else
        if self.dir == "down" then
            love.graphics.draw(self.AnimationWalkDown[math.floor(self.AnimationTimer)], x, y, 0,
                                self.rect.width / self.AnimationWalkDown[math.floor(self.AnimationTimer)]:getWidth(),
                                self.rect.height / self.AnimationWalkDown[math.floor(self.AnimationTimer)]:getHeight())
        elseif self.dir == "up" then
            love.graphics.draw(self.AnimationWalkUp[math.floor(self.AnimationTimer)], x, y, 0,
                                self.rect.width / self.AnimationWalkUp[math.floor(self.AnimationTimer)]:getWidth(),
                                self.rect.height / self.AnimationWalkUp[math.floor(self.AnimationTimer)]:getHeight())
        elseif self.dir == "right" then
            love.graphics.draw(self.AnimationWalkRight[math.floor(self.AnimationTimer)], x, y, 0,
                                self.rect.width / self.AnimationWalkRight[math.floor(self.AnimationTimer)]:getWidth(),
                                self.rect.height / self.AnimationWalkRight[math.floor(self.AnimationTimer)]:getHeight())
        elseif self.dir == "left" then
            love.graphics.draw(self.AnimationWalkRight[math.floor(self.AnimationTimer)], x + self.rect.width, y, 0,
                                -(self.rect.width / self.AnimationWalkRight[math.floor(self.AnimationTimer)]:getWidth()),
                                self.rect.height / self.AnimationWalkRight[math.floor(self.AnimationTimer)]:getHeight())
        end
    end
end