local game = {}

function game:enter()
    createWorld(plains1)
end

function game:update(dt)
    player:update(dt)
    cam:lookAt(player.rect.body:getX() + player.rect.width / 2, player.rect.body:getY() + player.rect.height / 2)
    
end

function game:draw()
    cam:attach()
        plains1:drawLayer(plains1.layers["Ground"])
        -- plains1:drawObjectLayer(plains1.layers["Walls"])

        -- love.graphics.setColor(1, 0, 0)
        -- for i,v in ipairs(walls) do
        --     love.graphics.rectangle("line", v.body:getX(), v.body:getY(), v.width, v.height)
        -- end
        -- love.graphics.setColor(1, 1, 1)

        plains1:drawLayer(plains1.layers["Objects"])
        player:draw()
    cam:detach()
end

function game:keypressed(key)
    if key == 'escape' then
        saveGame()
        gamestate.switch(menu)
    end
end

function game:leave()
    deleteWorld()
end

return game