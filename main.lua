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

data = {x = 100, y = 100, speed = 100}


function love.load()
    cam = camera(0, 0, 4)

    world = love.physics.newWorld(0, 0, true)

    gamestate.registerEvents()
    gamestate.switch(menu)

    plains1 = sti("maps/plains1.lua")
    lake1 = sti("maps/lake1.lua")

    walls = {}

    savedata = "savedata.txt"

     -- initialiser le joueur
    if love.filesystem.getInfo(savedata) then
        file = love.filesystem.read(savedata)
        data = lume.deserialize(file)
    end
    player = Player(data.x, data.y, data.speed)
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



function createWorld(map)
    if map.layers["Walls"] then
        for i, obj in pairs(map.layers["Walls"].objects) do
            local wall = createRect(obj.x + obj.width / 2, obj.y + obj.height / 2, obj.width, obj.height, "static", 1)
            table.insert(walls, wall)
        end
    end
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