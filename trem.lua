Trem = {}

function Trem.load()

end

function Trem.novo(world, razao, edge)
	
	-- Body of the car; a rectangle
	local trem = {}
	trem.width = 30;
	trem.height = 15;
	trem.y0		= 250;
	trem.body = love.physics.newBody(world, trem.width, 0 + trem.y0, "dynamic");
	
	trem.shape = love.physics.newRectangleShape(trem.width,trem.height)
	trem.fixture = love.physics.newFixture(trem.body, trem.shape)  
	trem.fixture:setFriction(30)
	trem.fixture:setDensity(2.5)
	--trem.body:setMass(500);
	trem.fixture:setRestitution(0)  
	
	-- First wheel
	local wheel1 = {}
	wheel1.pos = {x = 10 + trem.width/4.0, y = trem.height/2.0 + trem.y0 - 3}
	wheel1.body = love.physics.newBody(world, wheel1.pos.x, wheel1.pos.y , "dynamic")
	wheel1.shape = love.physics.newCircleShape(6)
	wheel1.fixture = love.physics.newFixture(wheel1.body, wheel1.shape)
	wheel1.fixture:setFriction(80)
	wheel1.fixture:setDensity(3)
	wheel1.fixture:setRestitution(0.0)
	
	-- Second wheel
	local wheel2 = {}
	wheel2.body = love.physics.newBody(world, 20 + trem.width*1.5/2.0, trem.height/2.0 + trem.y0, "dynamic")

	wheel2.shape = love.physics.newCircleShape(4)
	wheel2.fixture = love.physics.newFixture(wheel2.body, wheel2.shape)
	wheel2.fixture:setFriction(40)
	wheel2.fixture:setDensity(3)
	wheel2.fixture:setRestitution(0.0)
	
	-- Create joint between car body and first wheel
	trem.wheeljoint1 = love.physics.newRevoluteJoint(trem.body, wheel1.body, wheel1.pos.x, wheel1.pos.y)
	trem.wheeljoint1:setMotorEnabled(true);
	trem.wheeljoint1:setMaxMotorTorque(1100) -- Following example from http://www.emanueleferonato.com/2011/08/22/step-by-step-creation-of-a-box2d-cartruck-with-motors-and-shocks/

	-- Create joint between car body and second wheel
	trem.wheeljoint2 = love.physics.newRevoluteJoint(trem.body, wheel2.body, 20 + trem.width*1.5/2.0, trem.height/2.0 + trem.y0)
	--trem.wheeljoint2:setMotorEnabled(true);
	--trem.wheeljoint2:setMaxMotorTorque(250)

	return trem, wheel1, wheel2;
end




