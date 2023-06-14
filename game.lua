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