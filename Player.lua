Player = Object:extend()

function Player:new(x, y, speed)
    self.rect = createRect(x, y, 50, 100)
    self.limitX = love.graphics.getWidth() / 2 - self.rect.width / 2
    self.limitY = love.graphics.getHeight() / 2 - self.rect.height / 2
    self.speed = speed
end

function Player:update(dt)
    if love.keyboard.isDown("left") then
        self:left(dt)
    
    elseif love.keyboard.isDown("right") then
        self:right(dt)
    end
    if love.keyboard.isDown("up") then
        self:up(dt)
    
    elseif love.keyboard.isDown("down") then
        self:down(dt)
    end
end

function Player:draw()
    love.graphics.rectangle("fill",
                            self.limitX, 
                            self.limitY,
                            self.rect.width,
                            self.rect.height)
end

function Player:left(dt)
    -- vérifier si le mouvement rentrerait en collision avec un bloc
    if not collideList(rects, createRect(self.rect.x - self.speed * dt, self.rect.y, self.rect.width, self.rect.height)) then
        self.rect.x = self.rect.x - self.speed * dt
    end
end

function Player:right(dt)
    if not collideList(rects, createRect(self.rect.x + self.speed * dt, self.rect.y, self.rect.width, self.rect.height)) then
        self.rect.x = self.rect.x + self.speed * dt
    end
end

function Player:up(dt)
    if not collideList(rects, createRect(self.rect.x, self.rect.y - self.speed * dt, self.rect.width, self.rect.height)) then
        self.rect.y = self.rect.y - self.speed * dt
    end
end

function Player:down(dt)
    if not collideList(rects, createRect(self.rect.x, self.rect.y + self.speed * dt, self.rect.width, self.rect.height)) then
        self.rect.y = self.rect.y + self.speed * dt
    end
end