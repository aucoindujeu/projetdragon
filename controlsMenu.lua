local controlsMenu = {}

function controlsMenu:draw()
    love.graphics.print("Press Enter to continue", font, 100, 100)
end

function controlsMenu:keypressed(key)
    if key == 'escape' then
        gamestate.switch(menu)
    end
end

return controlsMenu