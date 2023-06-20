Heart = Object:extend()

Heart.Animation = {}
for i=0, 3 do
    table.insert(Heart.Animation, love.graphics.newImage("images/animations/heart_" .. i .. ".png"))
end

function Heart:new(x, y)
    self.rect = createRect(x, y, 20, 20, "static", 1)
    self.rect.body:setFixedRotation(true)
    self.rect.fixture:setUserData("Heart")

    self.AnimationTimer = 1
end

function Heart:update(dt)
    self.AnimationTimer = self.AnimationTimer + dt * 5
    if self.AnimationTimer >= 5 then
        self.AnimationTimer = 1
    end
end

function Heart:draw()
    local x = self.rect.body:getX() - self.rect.width / 2
    local y = self.rect.body:getY() - self.rect.height / 2
    love.graphics.draw(self.Animation[math.floor(self.AnimationTimer)], x, y, 0,
                        self.rect.width / self.Animation[math.floor(self.AnimationTimer)]:getWidth(),
                        self.rect.height / self.Animation[math.floor(self.AnimationTimer)]:getHeight())
end