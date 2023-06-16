Object = require "libraries.classic" -- importer des librairies
lume = require "libraries.lume"
gamestate = require "libraries.gamestate"
sti = require "libraries.sti"
camera = require "libraries.camera"

require "Player"
require "Button"
require "Rect"
require "Door"
menu = require "menu"
game = require "game"
controlsMenu = require "controlsMenu"


local windowWidth, windowHeight = love.window.getDesktopDimensions()
love.window.setMode(windowWidth, windowHeight)

font = love.graphics.newFont("DejaVuSans.ttf", 30) -- importer un font
love.graphics.setFont(font)

love.window.setTitle("Projet Dragon")

data = {x = 5 * 16 * 20, y = 5 * 16 * 20, speed = 80, newWorld = true,
        tileSet = {
            {{1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}},
            {{1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}},
            {{1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}},
            {{1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}},
            {{1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}},
            {{1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}},
            {{1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}},
            {{1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}},
            {{1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}},
            {{1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}},
        }}


function love.load()
    love.math.setRandomSeed(os.time())

    cam = camera(0, 0, 1)

    world = love.physics.newWorld(0, 0, true)

    gamestate.registerEvents()
    gamestate.switch(menu)

    walls = {}

    savedata = "savedata.txt"

     -- initialiser le joueur
    if love.filesystem.getInfo(savedata) then
        file = love.filesystem.read(savedata)
        data = lume.deserialize(file)
    end
    player = Player(data.x, data.y, data.speed)
    -- print(data.newWorld)
end

function love.update(dt)
    world:update(dt)
end

function love.draw()
end

function love.keypressed(key)
    if key == "q" then
        love.load()
    end
    if key == "s" then
        saveGame()
    end
end


function createRect(x, y, w, h, t, d, mask) -- x:Xpos, y:Ypos, w:Width, h:Height, t:Type("static", "dynamic"), d:Density, mask:setMask
    local mask = mask or 16
    local rect = {
    body = love.physics.newBody( world, x, y, t ),
    shape = love.physics.newRectangleShape(w, h),
    }
    rect.width = w
    rect.height = h 
    rect.fixture = love.physics.newFixture( rect.body, rect.shape, d )
    rect.fixture:setMask(mask)
    return rect
end



function createWorld(newWorld)
    local tiles = {}
    local tileSet = data.tileSet

    local loops = 1
    for y, v in ipairs(tileSet) do
        for x, w in ipairs(v) do
            local choices = {["1"] = 2, ["2"] = 0.5, ["3"] = 0.3, ["4"] = 0.06}

            if data.newWorld then

                -- 1: plains, 2: lake, 3: village, 4: shrine

                local plainsChance = 2.5
                local lakeChance = 0.25
                local villageChance = 0.8
                local shrineChance = 0

                if x > 1 then  
                    if tileSet[y][x - 1][1] == "1" then
                        choices["1"] = plainsChance
                    elseif tileSet[y][x - 1][1] == "2" then
                        choices["2"] = lakeChance
                    elseif tileSet[y][x - 1][1] == "3" then
                        choices["3"] = villageChance
                    elseif tileSet[y][x - 1][1] == "4" then
                        choices["4"] = shrineChance
                        choices["3"] = villageChance
                    end

                elseif y > 1 and x > 1 then
                    if tileSet[y - 1][x][1] == "1" or tileSet[y][x - 1][1] == "1" then
                        choices["1"] = plainsChance
                    elseif tileSet[y - 1][x][1] == "2" or tileSet[y][x - 1][1] == "2" then
                        choices["2"] = lakeChance
                    elseif tileSet[y - 1][x][1] == "3" or tileSet[y][x - 1][1] == "3" then
                        choices["3"] = villageChance
                    elseif tileSet[y - 1][x][1] == "4" then
                        choices["4"] = shrineChance
                        choices["3"] = villageChance
                    end
                end

                tileSet[y][x][1] = lume.weightedchoice(choices)
                tileSet[y][x][2] = love.math.random(1, 2)
            end

            local ox = (x - 1) * 16 * 20
            local oy = (y - 1) * 16 * 20
            
            if tileSet[y][x][1] == "1" then
                table.insert(tiles, sti("maps/plains" .. tileSet[y][x][2] .. ".lua", {}, ox, oy))
            elseif tileSet[y][x][1] == "2" then
                table.insert(tiles, sti("maps/lake" .. tileSet[y][x][2] .. ".lua", {}, ox, oy))
            elseif tileSet[y][x][1] == "3" then
                table.insert(tiles, sti("maps/village" .. tileSet[y][x][2] ..".lua", {}, ox, oy))
            elseif tileSet[y][x][1] == "4" then
                table.insert(tiles, sti("maps/shrine1.lua", {}, ox, oy))
            else
                table.insert(tiles, sti("maps/plains1.lua", {}, ox, oy))
            end
            if tiles[loops].layers["Walls"] then
                for i, obj in pairs(tiles[loops].layers["Walls"].objects) do
                    local wall = createRect(obj.x + obj.width / 2 + ox, obj.y + obj.height / 2 + oy, obj.width, obj.height, "static", 1)
                    table.insert(walls, wall)
                end
            end
            loops = loops + 1
        end
    end
    print(tileSet[1][1])
    data.tileSet = tileSet
    data.newWorld = false
    return tiles
end

function deleteWorld()
    for i,v in ipairs(walls) do
        v.fixture:destroy()
    end
    lume.clear(walls)
end



function saveGame()
    data.x = player.rect.body:getX()
    data.y = player.rect.body:getY()
    data.speed = player.speed
    serialized = lume.serialize(data)
    love.filesystem.write(savedata, serialized)
end

function resetGame()
    love.filesystem.remove(savedata)
    love.event.quit("restart")
end