Trem = {}

function Trem.load()

end

function Trem.novo(world, razao)
	
	-- Body of the car; a rectangle
	local trem = {}
	trem.width = 50;
	trem.height = 25;
	trem.body = love.physics.newBody(world, trem.width, 0, "dynamic")
	trem.shape = love.physics.newRectangleShape(trem.width,trem.height)
	trem.fixture = love.physics.newFixture(trem.body, trem.shape)  
	trem.fixture:setFriction(3)
	trem.fixture:setDensity(3)
	trem.fixture:setRestitution(0)  
	
	-- First wheel
	local wheel1 = {}
	wheel1.body = love.physics.newBody(world, 25 + trem.width/4.0, trem.height/2.0, "dynamic")
	wheel1.shape = love.physics.newCircleShape(trem.width/8.0)
	wheel1.fixture = love.physics.newFixture(wheel1.body, wheel1.shape)
	wheel1.fixture:setFriction(3)
	wheel1.fixture:setDensity(3)
	wheel1.fixture:setRestitution(0.6)
	
	-- Second wheel
	local wheel2 = {}
	wheel2.body = love.physics.newBody(world, 25 + trem.width*1.5/2.0, trem.height/2.0, "dynamic")
	wheel2.shape = love.physics.newCircleShape(trem.width/8.0)
	wheel2.fixture = love.physics.newFixture(wheel2.body, wheel2.shape)
	wheel2.fixture:setFriction(3)
	wheel2.fixture:setDensity(3)
	wheel2.fixture:setRestitution(0.6)
	
	-- Create joint between car body and first wheel
	trem.wheeljoint1 = love.physics.newRevoluteJoint(trem.body, wheel1.body, 25 + trem.width/4.0, trem.height/2.0)
	trem.wheeljoint1:setMotorEnabled(true);
	--print(objects.carbody.wheeljoint1:getType());
	--objects.carbody.wheeljoint1:enableMotor(true) 
	trem.wheeljoint1:setMaxMotorTorque(10000) -- Following example from http://www.emanueleferonato.com/2011/08/22/step-by-step-creation-of-a-box2d-cartruck-with-motors-and-shocks/

	-- Create joint between car body and second wheel
	trem.wheeljoint2 = love.physics.newRevoluteJoint(trem.body, wheel2.body, 25 + trem.width*1.5/2.0, trem.height/2.0)
	trem.wheeljoint2:setMotorEnabled(true);
	trem.wheeljoint2:setMaxMotorTorque(10000)
	
	
	return trem, wheel1, wheel2;
end