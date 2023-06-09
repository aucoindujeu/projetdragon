Object = require "classic" -- importer des librairies
lume = require "lume"
require "Player"
require "Button"


windowWidth, windowHeight = love.window.getDesktopDimensions()
love.window.setMode(windowWidth, windowHeight)

font = love.graphics.newFont("DejaVuSans.ttf", 30) -- importer un font
love.graphics.setFont(font)

love.window.setTitle("Projet Dragon")


function love.load()

    savedata = "savedata.txt"

     -- initialiser le joueur
    if love.filesystem.getInfo(savedata) then
        file = love.filesystem.read(savedata)
        data = lume.deserialize(file)
        player = Player(data.x, data.y, data.speed)
    else
        player = Player(100, 100, 100)
    end

    tilemaps = {}
    tilemaps.overworld = {  -- initialiser le monde
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
        {0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0},
        {0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0},
        {0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0},
        {0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0},
        {0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0},
    }

    rects = {}
    local size = 50
    rects = createWorld(tilemaps.overworld, size, rects) -- création du monde

    inMenu = true

    menuButtons = {
        Button(100, 100, 100, 50, "Start!", "start"),
        Button(100, 300, 180, 50, "New Game!", "newGame"),
        Button(100, 500, 100, 50, "Quit:(", "quit")
    }
end

function love.update(dt)
    if not inMenu then
        player:update(dt)
    else
        if love.mouse.isDown(1) then
            if inMenu then
                for i,v in ipairs(menuButtons) do
                    local returnValue = v:update()
                    if returnValue == "Start Game" then
                        inMenu = false
                    end
                end
            end
        end
    end
end

function love.draw()

    if not inMenu then
        love.graphics.setBackgroundColor(0/255, 0/255, 0/255)
        love.graphics.setColor(0/255, 255/255, 0/255)

        -- afficher les obstacles relativement au joueur
        for i,v in ipairs(rects) do
            love.graphics.rectangle("fill", v.x - player.rect.x + player.limitX, v.y - player.rect.y + player.limitY, v.width, v.height)
        end

        love.graphics.setColor(255/255, 255/255, 255/255)

        -- afficher le joueur
        player:draw()
    else
        love.graphics.setBackgroundColor(37/255, 91/255, 141/255)

        for i,v in ipairs(menuButtons) do
            v:draw()
        end
    end

end

function love.keypressed(key)
    if key == "q" then
        love.load()
    end
    if key == "escape" then
        saveGame()
        if inMenu then
            love.event.quit()
        else
            inMenu = true
        end
    end
    if key == "s" then
        saveGame()
    end
end

function createRect(x, y, width, height)
    return {x = x, y = y, width = width, height = height}
end

function collideRect(rect1, rect2)
    return (rect1.x + rect1.width > rect2.x and rect1.x < rect2.x + rect2.width and 
            rect1.y + rect1.height > rect2.y and rect1.y < rect2.y + rect2.height)
end

function collidePoint(x, y, rect)
    return (x > rect.x and x < rect.x + rect.width and 
            y > rect.y and y < rect.y + rect.height)
end

function collideList(list, rect)
    for i,v in ipairs(list) do
        if collideRect(v, rect) == true then
            return true
        end
    end
    return false
end

function createWorld(tilemap, size, rects)
    for y,v in ipairs(tilemap) do
        for x,w in ipairs(tilemap[y]) do
            if w == 1 then
                table.insert(rects, createRect(x * size, y * size, size, size))
            end
        end
    end

    return rects
end

function deleteWorld(rects)
    return lume.clear(rects)
end

function saveGame()
    local data = {x = player.rect.x, y = player.rect.y, speed = player.speed}
    serialized = lume.serialize(data)
    love.filesystem.write(savedata, serialized)
end

function resetGame()
    love.filesystem.remove(savedata)
    love.event.quit("restart")
end