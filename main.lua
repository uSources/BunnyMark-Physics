require "assets"
require "opt"
local Bunny = require "Bunny"
local BUNNY_COUNT = 0
local world
local Pool = {}
local stats = love.graphics.getStats()
local batch = love.graphics.newSpriteBatch(bunny_sprite)
local green = {0, 1, 0, 1}

function love.load()
  love.physics.setMeter(HEIGHT_METERS)
  world = love.physics.newWorld(0,PHYSICS_FORCE * HEIGHT_METERS, true)
end
function love.draw()
  love.graphics.draw(batch, x, y)
  love.graphics.setBackgroundColor(1, 1, 1, 1)
  love.graphics.print({green, "Bunnies:" .. #Pool}, 10, 10)
  love.graphics.print({green, "FPS:" .. love.timer.getFPS()}, 10, 25)
  love.graphics.print({green, "MEMORY:" .. stats.texturememory}, 10, 40)
  love.graphics.print({green, "CALLBACKS:" .. stats.drawcalls}, 10, 55)
end

function love.update(dt)
  world:update(dt)
  batch:clear()
  for i, bunny in ipairs(Pool) do
    bunny:update(dt)
    batch:setColor(bunny.color.r, bunny.color.g, bunny.color.b, bunny.color.a)
    batch:add(bunny.x, bunny.y)
  end
end

function love.mousepressed(x, y, button, istouch)
  if button == 1 and MAX_BUNNYES > BUNNY_COUNT then
    for i = 1, BUNNY_SPANW do
      BUNNY_COUNT = BUNNY_COUNT + 1
      local x, y = love.mouse.getPosition()
      table.insert(Pool, Bunny:create(world, x, y))
    end
  end
end
