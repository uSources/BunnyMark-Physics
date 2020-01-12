require "assets"
Bunny = {}
Bunny.__index = Bunny
local DIRECTIONS = {-1, 1}

function Bunny:create(world, x, y)
    local o = {}
    setmetatable(o, Bunny)
    o.x = x or 1
    o.y = y or 1
    o.body = love.physics.newBody(world, x, y, "dynamic")
    o.shape = love.physics.newRectangleShape(bunny_sprite:getWidth(), bunny_sprite:getHeight())
    o.fixture = love.physics.newFixture(o.body, o.shape)
    o.fixture:setMask(1)
    o.speed = math.random(100,300)
    o.color = {}
    o.color.r = math.random(0, 1)
    o.color.g = math.random(0, 1)
    o.color.b = math.random(0, 1)
    o.color.a = 1
    o.linearX = (math.random() * DIRECTIONS[math.random(1, 2)]) * o.speed
    o.linearY = (math.random() * DIRECTIONS[math.random(1, 2)]) * o.speed
    o.body:setLinearVelocity(o.linearX, o.linearY)
    return o
end

function Bunny:draw()
end

function Bunny:update(dt)
    self.linearX, self.linearY = self.body:getLinearVelocity()
    if self.body:getX() < 0 or self.body:getX() > love.graphics.getWidth() then
        self.linearX = -1 * self.linearX
    end
    if self.body:getY() < 0 or self.body:getY() > love.graphics.getHeight() then
        self.linearY = -1 * self.linearY
    end
    self.body:setLinearVelocity(self.linearX, self.linearY)
    self.x, self.y = self.body:getPosition()
end

return Bunny
