Button = Object:extend()

function Button:new(x, y, w, h, text, fn)
    self.rect = createRect(x, y, w, h)
    self.text = text
    self.fn = fn
end

function Button:update(x, y)
    if collidePoint(x, y, self.rect) then
        if self.fn == "start" then
            return "startGame"
        elseif self.fn == "newGame" then
            resetGame()
        elseif self.fn == "quit" then
            love.event.quit()
        elseif self.fn == "controls" then
            return "enterControls"
        end
    end
end

function Button:draw()
    love.graphics.setColor(0, 1, 0)
    love.graphics.rectangle("line", self.rect.x, self.rect.y, self.rect.width, self.rect.height)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(self.text, font, self.rect.x, self.rect.y)
end