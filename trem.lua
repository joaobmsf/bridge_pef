Trem = {}

function Trem.load()

end

function Trem.novo(world, razao)

	-- Body of the car; a rectangle
	trem = {}
	trem.body = love.physics.newBody(world, 50, 0, "dynamic")
	trem.shape = love.physics.newRectangleShape(50,25)
	trem.fixture = love.physics.newFixture(trem.body, trem.shape)  
	trem.fixture:setFriction(3)
	trem.fixture:setDensity(3)
	trem.fixture:setRestitution(0)  
	--[[
	-- First wheel
	objects.wheel = {}
	objects.wheel.body = love.physics.newBody(world, 330, 520, "dynamic")
	objects.wheel.shape = love.physics.newCircleShape(20)
	objects.wheel.fixture = love.physics.newFixture(objects.wheel.body, objects.wheel.shape)
	objects.wheel.fixture:setFriction(3)
	objects.wheel.fixture:setDensity(3)
	objects.wheel.fixture:setRestitution(0.6)

	-- Second wheel
	objects.wheel2 = {}
	objects.wheel2.body = love.physics.newBody(world, 270, 520, "dynamic")
	objects.wheel2.shape = love.physics.newCircleShape(20)
	objects.wheel2.fixture = love.physics.newFixture(objects.wheel2.body, objects.wheel2.shape)
	objects.wheel2.fixture:setFriction(3)
	objects.wheel2.fixture:setDensity(3)
	objects.wheel2.fixture:setRestitution(0.6)

	-- Create joint between car body and first wheel
	objects.carbody.wheeljoint1 = love.physics.newRevoluteJoint(objects.carbody.body, objects.wheel.body, 330, 520)
	objects.carbody.wheeljoint1:setMotorEnabled(true);
	print(objects.carbody.wheeljoint1:getType());
	--objects.carbody.wheeljoint1:enableMotor(true) 
	objects.carbody.wheeljoint1:setMaxMotorTorque(10000) -- Following example from http://www.emanueleferonato.com/2011/08/22/step-by-step-creation-of-a-box2d-cartruck-with-motors-and-shocks/

	-- Create joint between car body and second wheel
	objects.carbody.wheeljoint2 = love.physics.newRevoluteJoint(objects.carbody.body, objects.wheel2.body, 270, 520)
	--objects.carbody.wheeljoint2:enableMotor(true) 
	objects.carbody.wheeljoint2:setMaxMotorTorque(10000)
	--]]
	
	return trem;
end