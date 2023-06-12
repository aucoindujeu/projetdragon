Object = require "classic" -- importer des librairies
lume = require "lume"
require "Player"
require "Button"
require "Rect"
require "Door"


local windowWidth, windowHeight = love.window.getDesktopDimensions()
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
        player = Player(data.x, data.y, data.speed, data.location)
    else
        player = Player(100, 100, 200, "overworld")
    end

    tilemaps = {}
    tilemaps.overworld = {  -- initialiser le monde
        {20, 10, 10, 10, 10, 10, 10, 10, 10, 11, 10},
        {10, 10, 10, 10, 11, 10, 10, 10, 10, 11, 10},
        {10, 10, 10, 10, 11, 10, 10, 10, 10, 11, 10},
        {10, 10, 10, 10, 11, 10, 10, 10, 10, 11, 10},
        {10, 10, 10, 10, 11, 10, 10, 10, 10, 11, 10},
        {10, 10, 10, 10, 11, 10, 10, 10, 12, 11, 10},
    }

    tilemaps.underworld = {  -- initialiser le monde
        {21, 10, 10, 10, 10, 10, 10, 10, 12, 11, 10},
        {10, 10, 10, 10, 11, 10, 10, 10, 12, 11, 10},
        {10, 10, 10, 10, 11, 10, 10, 10, 12, 11, 10},
        {10, 10, 10, 10, 11, 10, 10, 10, 12, 11, 10},
        {10, 10, 10, 10, 11, 10, 10, 10, 12, 11, 10},
        {10, 10, 10, 11, 11, 10, 10, 10, 12, 11, 10},
    }

    rects = {}
    doors = {}
    local size = 50
    if player.location == "overworld" then
        createWorld(tilemaps.overworld, size) -- création du monde
    elseif player.location == "underworld" then
        createWorld(tilemaps.underworld, size)
    end

    gameStates = {
        inMenu = true,
        inControlsMenu = false,
        inGame = false
    }

    menuButtons = {
        Button(100, 100, 100, 50, "Start!", "start"),
        Button(100, 300, 180, 50, "New Game!", "newGame"),
        Button(100, 500, 100, 50, "Quit:(", "quit"),
        Button(300, 100, 150, 50, "Controls", "controls")
    }
end

function love.update(dt)
    if gameStates.inGame then
        player:update(dt)

    elseif gameStates.inMenu then
        if love.mouse.isDown(1) then
            local x, y = love.mouse.getX(), love.mouse.getY()
            for i,v in ipairs(menuButtons) do
                local returnValue = v:update(x, y)
                if returnValue == "startGame" then
                    resetGameStates()
                    gameStates.inGame = true
                elseif returnValue == "enterControls" then
                    resetGameStates()
                    gameStates.inControlsMenu = true
                end
            end
        end
    end
end

function love.draw()

    if gameStates.inGame then
        love.graphics.setBackgroundColor(0/255, 0/255, 0/255)

        -- afficher les obstacles relativement au joueur
        for i,v in ipairs(rects) do
            v:draw()
        end
        for i,v in ipairs(doors) do
            v:draw()
        end

        love.graphics.setColor(255/255, 255/255, 255/255)

        -- afficher le joueur
        player:draw()

    elseif gameStates.inMenu then
        love.graphics.setBackgroundColor(37/255, 91/255, 141/255)

        for i,v in ipairs(menuButtons) do
            v:draw()
        end
    
    elseif gameStates.inControlsMenu then
        love.graphics.setBackgroundColor(37/255, 91/255, 141/255)

        love.graphics.print("move: arrow keys\n\nreturn: escape", 100, 100)
    end

end

function love.keypressed(key)
    if key == "q" then
        love.load()
    end
    if key == "escape" then
        saveGame()
        if gameStates.inGame then
            resetGameStates()
            gameStates.inMenu = true
        elseif gameStates.inMenu then
            love.event.quit()  
        elseif gameStates.inControlsMenu then
            resetGameStates()
            gameStates.inMenu = true
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

function collideList(list, rect, isClass)
    isClass = isClass or false
    if isClass then
        for i,v in ipairs(list) do
            if collideRect(v.rect, rect) then
                return true
            end
        end
    else
        for i,v in ipairs(list) do
            if collideRect(v, rect) then
                return true
            end
        end
    end
    return false
end



function createWorld(tilemap, size)
    for y,v in ipairs(tilemap) do
        for x,w in ipairs(tilemap[y]) do
            if w == 11 then
                table.insert(rects, Rect(x * size, y * size, size, size, "rect"))
            elseif w == 12 then
                table.insert(rects, Rect(x * size, y * size, size, size, "rectBlue"))
            elseif w == 20 then
                table.insert(doors, Door(x * size, y * size, size, size, "underworld"))
            elseif w == 21 then
                table.insert(doors, Door(x * size, y * size, size, size, "overworld"))
            end
        end
    end
end

function deleteWorld()
    lume.clear(rects)
    lume.clear(doors)
end

function changeWorld(door, size)
    deleteWorld()
    if door.destination == "overworld" then
        createWorld(tilemaps.overworld, size)
    elseif door.destination == "underworld" then
        createWorld(tilemaps.underworld, size)
    end
    player.location = door.destination
    player.rect.x = door.rect.x
    player.rect.y = door.rect.y + door.rect.height + 5
end



function resetGameStates()
    for k,v in pairs(gameStates) do
        gameStates[k] = false
    end
end



function saveGame()
    local data = {x = player.rect.x, y = player.rect.y, speed = player.speed, location = player.location}
    serialized = lume.serialize(data)
    love.filesystem.write(savedata, serialized)
end

function resetGame()
    love.filesystem.remove(savedata)
    love.event.quit("restart")
end