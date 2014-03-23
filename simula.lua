require 'trem'
require 'aresta'
Simula = {}

function Simula.drawBotao ()
    love.graphics.setColor(0, 0, 0);
    love.graphics.rectangle("fill", 25, 525, 50, 50);    
    love.graphics.setColor(255, 255, 255);
    love.graphics.print("Play",37.5,545);
end

function Simula.drawBotaoooooooooo ()
    love.graphics.setColor(0, 0, 200);
    love.graphics.rectangle("fill", 525, 525, 50, 50);
end

function Simula.verificaPlay(conj)
    
    for i = 1, conj.nJuncoes do
		for j = 1, i do
			if i ~= j and conj.matrix[i][j] ~= nil then
                conj.matrix[i][j].valido = 0;
            end
        end
    end

    local flag=1;
    while flag == 1 do
        flag = 0;
        for i = 1, conj.nJuncoes do
            for j = 1, i do
                if i ~= j and conj.matrix[i][j] ~= nil and conj.matrix[i][j].valido == 0 then
                    if conj.juncoes[i].tipo==Juncao.FIXA or conj.juncoes[j].tipo==Juncao.FIXA then
                        conj.matrix[i][j].valido = 1;
                        flag=1;
                        break;
                    else
                        for k = 1, conj.nJuncoes do
                            if i ~= k and conj.matrix[i][k] ~= nil and conj.matrix[i][k].valido == 1 then
                                conj.matrix[i][j].valido = 1;
                                flag=1;
                                break;
                            end
                            if j ~= k and conj.matrix[j][k] ~= nil and conj.matrix[j][k].valido == 1 then
                                conj.matrix[i][j].valido = 1;
                                flag=1;
                                break;
                            end
                        end
                    end
                end
            end
        end
    end

    for i = 1, conj.nJuncoes do
		for j = 1, i do
			if i ~= j and conj.matrix[i][j] ~= nil then
                if conj.matrix[i][j].valido == 0 then
                    return 0;
                end
            end
        end
    end

    return 1;
end

function Simula.addEdgeShape(aresta)
	edge = {}
	edge.body = love.physics.newBody(Simula.world, aresta.j1.pos.x, aresta.j1.pos.y)
	edge.shape = love.physics.newEdgeShape(0, 0, aresta.j2.pos.x - aresta.j1.pos.x, aresta.j2.pos.y - aresta.j1.pos.y);
	edge.fixture = love.physics.newFixture(edge.body, edge.shape)
	edge.fixture:setFriction(3)
end

function Simula.inicia(conj)
	local pixelInMeter = 50;
	-- Set up world
	love.physics.setMeter(pixelInMeter)
	Simula.world = love.physics.newWorld(0, 9.81*pixelInMeter, true);
	Simula.trem, Simula.wheel1, Simula.wheel2 = Trem.novo(Simula.world, pixelInMeter);
	
	for i = 1, conj.nJuncoes do
		for j = 1, i do
			if i ~= j and conj.matrix[i][j] ~= nil then
				if conj.matrix[i][j].tipo == Aresta.CAMINHO then
				 Simula.addEdgeShape(conj.matrix[i][j]);
				end				
			end
		end
	end 
	
	Simula.running = true;
end

function Simula.update(dt)
	if Simula.running == true then
		Simula.trem.wheeljoint1:setMotorSpeed(20)
		Simula.trem.wheeljoint2:setMotorSpeed(20)
		Simula.world:update(dt)
	end
end

function Simula.draw()
	Simula.drawBotao()
	if Simula.running == true then
		print("ola");
		love.graphics.setColor(200, 156, 27);
		love.graphics.polygon("fill", Simula.trem.body:getWorldPoints(Simula.trem.shape:getPoints()))
		love.graphics.setColor(40, 46, 127);
		love.graphics.circle("line", Simula.wheel1.body:getX(), Simula.wheel1.body:getY(), Simula.wheel1.shape:getRadius())  
		love.graphics.circle("line", Simula.wheel2.body:getX(), Simula.wheel2.body:getY(), Simula.wheel2.shape:getRadius()) 		
	end
end







