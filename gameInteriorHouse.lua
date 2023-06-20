local gameInteriorHouse = {}

function gameInteriorHouse:enter()
    player.location = "InteriorHouse1"
    
    createChunk(maps["house1"], player.rect.body:getX() - 10 * 16, player.rect.body:getY() - 12 * 16)
    maps["house1"]:translate(player.rect.body:getX() - 10 * 16, player.rect.body:getY() - 12 * 16)
end

function gameInteriorHouse:update(dt)
    player:update(dt)
    cam:lookAt(player.rect.body:getX() + player.rect.width / 2, player.rect.body:getY() + player.rect.height / 2)
    for i, heart in ipairs(hearts) do
        heart:update(dt)
        if heart.rect.fixture:isDestroyed() then
            table.remove(hearts, i)
        end
    end
end

function gameInteriorHouse:draw()
    cam:attach()
        -- plains1:drawObjectLayer(plains1.layers["Walls"])

        -- love.graphics.setColor(1, 0, 0)
        -- for i,v in ipairs(walls) do
        --     love.graphics.rectangle("line", v.body:getX(), v.body:getY(), v.width, v.height)
        -- end
        -- love.graphics.setColor(1, 1, 1)
        drawChunk1(maps["house1"])

        player:draw()

        for i, heart in ipairs(hearts) do
            heart:draw(dt)
        end

        drawChunk2(maps["house1"])

    cam:detach()

    player:drawHearts(0, 0)
end

function gameInteriorHouse:keypressed(key)
    if key == 'escape' then
        saveGame()
        gamestate.switch(menu)
    end
end

function gameInteriorHouse:leave()
    deleteWorld()
end

return gameInteriorHouse