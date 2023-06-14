local menu = {}

function menu:enter()
    menu.buttons = {
        Button(100, 100, 100, 50, "Start!", "start"),
        Button(100, 300, 180, 50, "New Game!", "newGame"),
        Button(100, 500, 100, 50, "Quit:(", "quit"),
        Button(300, 100, 150, 50, "Controls", "controls"),
    }
end

function menu:update(dt)
    if love.mouse.isDown(1) then
        local x, y = love.mouse.getX(), love.mouse.getY()
        for i,v in ipairs(menu.buttons) do
            local returnValue = v:update(x, y)
            if returnValue == "startGame" then
                gamestate.switch(game)
            elseif returnValue == "enterControls" then
                gamestate.switch(controlsMenu)
            end
        end
    end
end

function menu:draw()
    for i,v in ipairs(menu.buttons) do
        v:draw()
    end
end

function menu:keypressed(key)
    if key == 'return' then
        gamestate.switch(game)
    elseif key == 'escape' then
        love.event.quit()
    end
end

function menu:leave()
    for i,v in ipairs(menu.buttons) do
        v.rect.fixture:destroy()
    end
    lume.clear(menu.buttons)
end

return menu