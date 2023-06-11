Door = Object:extend()

function Door:new(x, y, w, h, destination)
    self.rect = createRect(x, y, w, h)
    self.destination = destination
end

function Door:draw()
    -- vérifier si l'obstacle est sur l'écran
    if self.rect.x + self.rect.width - player.rect.x + player.limitX > 0    and    self.rect.x - player.rect.x + player.limitX < love.graphics.getWidth() and
    self.rect.y + self.rect.height - player.rect.y + player.limitY > 0    and    self.rect.y - player.rect.y + player.limitY < love.graphics.getHeight() then
        love.graphics.setColor(255/255, 0/255, 0/255)
        love.graphics.rectangle("fill", self.rect.x - player.rect.x + player.limitX, self.rect.y - player.rect.y + player.limitY, self.rect.width, self.rect.height)
    end
end