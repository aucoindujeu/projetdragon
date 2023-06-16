local game = {}

function game:enter()
    game.tiles = createWorld(data.newWorld)
end

function game:update(dt)
    player:update(dt)
    cam:lookAt(player.rect.body:getX() + player.rect.width / 2, player.rect.body:getY() + player.rect.height / 2)
end

function game:draw()
    cam:attach()
        -- plains1:drawObjectLayer(plains1.layers["Walls"])

        -- love.graphics.setColor(1, 0, 0)
        -- for i,v in ipairs(walls) do
        --     love.graphics.rectangle("line", v.body:getX(), v.body:getY(), v.width, v.height)
        -- end
        -- love.graphics.setColor(1, 1, 1)

        for i, v in ipairs(game.tiles) do
            if v.layers["Ground"] then
                v:drawLayer(v.layers["Ground"])
            end
            if v.layers["Objects"] then
                v:drawLayer(v.layers["Objects"])
            end
            if v.layers["Objects2"] then
                v:drawLayer(v.layers["Objects2"])
            end
        end
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