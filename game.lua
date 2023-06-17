local game = {}

function game:enter()
    createWorld(data.newWorld)
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

        for y,v in ipairs(data.tileSet) do
            for x,w in ipairs(v) do
                local ox = (x - 1) * 16 * 20
                local oy = (y - 1) * 16 * 20

                if data.tileSet[y][x][1] == "1" then
                    maps["plains" .. data.tileSet[y][x][2]]:translate(ox, oy)
                    drawChunk1(maps["plains" .. data.tileSet[y][x][2]])
                elseif data.tileSet[y][x][1] == "2" then
                    maps["lake" .. data.tileSet[y][x][2]]:translate(ox, oy)
                    drawChunk1(maps["lake" .. data.tileSet[y][x][2]])
                elseif data.tileSet[y][x][1] == "3" then
                    maps["village" .. data.tileSet[y][x][2]]:translate(ox, oy)
                    drawChunk1(maps["village" .. data.tileSet[y][x][2]])
                elseif data.tileSet[y][x][1] == "4" then
                    maps["shrine1"]:translate(ox, oy)
                    drawChunk1(maps["shrine1"])
                elseif data.tileSet[y][x][1] == "5" then
                    maps["forest1"]:translate(ox, oy)
                    drawChunk1(maps["forest1"])
                else
                    maps["plains1"]:translate(ox, oy)
                    drawChunk1(maps["plains1 "])
                end
            end
        end

        player:draw()

        for y,v in ipairs(data.tileSet) do
            for x,w in ipairs(v) do
                local ox = (x - 1) * 16 * 20
                local oy = (y - 1) * 16 * 20

                if data.tileSet[y][x][1] == "1" then
                    maps["plains" .. data.tileSet[y][x][2]]:translate(ox, oy)
                    drawChunk2(maps["plains" .. data.tileSet[y][x][2]])
                elseif data.tileSet[y][x][1] == "2" then
                    maps["lake" .. data.tileSet[y][x][2]]:translate(ox, oy)
                    drawChunk2(maps["lake" .. data.tileSet[y][x][2]])
                elseif data.tileSet[y][x][1] == "3" then
                    maps["village" .. data.tileSet[y][x][2]]:translate(ox, oy)
                    drawChunk2(maps["village" .. data.tileSet[y][x][2]])
                elseif data.tileSet[y][x][1] == "4" then
                    maps["shrine1"]:translate(ox, oy)
                    drawChunk2(maps["shrine1"])
                elseif data.tileSet[y][x][1] == "5" then
                    maps["forest1"]:translate(ox, oy)
                    drawChunk2(maps["forest1"])
                else
                    maps["plains1"]:translate(ox, oy)
                    drawChunk2(maps["plains1 "])
                end
            end
        end

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