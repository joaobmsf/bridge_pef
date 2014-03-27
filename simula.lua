require 'trem'

require 'aresta'

Simula = {}

function Simula.drawBotao (megaestado)
    love.graphics.setColor(0, 0, 0);
    love.graphics.rectangle("fill", 25, 525, 50, 50);    
    love.graphics.setColor(255, 255, 255);
    if megaestado == Game.CONSTRUCAO then
        love.graphics.print("Play",37.5,545);
    else
        love.graphics.print("Edit",37.5,545);
    end
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
	local edge = {}
	edge.body = love.physics.newBody(Simula.world, aresta.j1.pos.x, aresta.j1.pos.y)
	edge.shape = love.physics.newEdgeShape(0, 0, aresta.j2.pos.x - aresta.j1.pos.x, aresta.j2.pos.y - aresta.j1.pos.y);
	edge.fixture = love.physics.newFixture(edge.body, edge.shape)
	edge.fixture:setFriction(3)
    return edge
end

function Simula.inicia(conj)
	local pixelInMeter = 50;
	-- Set up world
	love.physics.setMeter(pixelInMeter)
	Simula.world = love.physics.newWorld(0, 20.81*pixelInMeter, true);
	Simula.conj  = conj;
	local edges  = {}
    for i = 1, conj.nJuncoes do
		for j = 1, i do
			if i ~= j and conj.matrix[i][j] ~= nil then
				if conj.matrix[i][j].tipo == Aresta.CAMINHO then
				 edges[#edges] = Simula.addEdgeShape(conj.matrix[i][j]);
				end				
			end
		end
	end
	local edge1 = {}
	edge1.body = love.physics.newBody(Simula.world, 0, 300)
	edge1.shape = love.physics.newEdgeShape(0, 0, 200 - 0, 300 - 300);
	edge1.fixture = love.physics.newFixture(edge1.body, edge1.shape)
	edge1.fixture:setFriction(3)

	local edge2 = {}
	edge2.body = love.physics.newBody(Simula.world, 800, 200)
	edge2.shape = love.physics.newEdgeShape(0, 0, 600 - 800, 200 - 200);
	edge2.fixture = love.physics.newFixture(edge2.body, edge2.shape)
	edge2.fixture:setFriction(3)
    
    Simula.trem, Simula.wheel1, Simula.wheel2 = Trem.novo(Simula.world, pixelInMeter, edges);

	Simula.running = true;
end

function Simula.verificaAresta(conj)
	Simula.trem.pos = Vetor2D.new(Simula.trem.body:getX(),Simula.trem.body:getY());
	for i = 1, conj.nJuncoes do
		for j = 1, i do
			if i ~= j and conj.matrix[i][j] ~= nil then
				if conj.matrix[i][j].tipo == Aresta.CAMINHO then
					local dista = Vetor2D.distanciaPontoReta(conj.juncoes[i].pos, conj.juncoes[j].pos, Simula.trem.pos);
					local inter = Vetor2D.estaNoIntervalo(conj.juncoes[i].pos, conj.juncoes[j].pos, Simula.trem.pos, 15);
					
					if dista <= 15 and inter == true then
						return conj.matrix[i][j];
					end
				end
			end
		end
	end
	return nil;
end


function Simula.update(dt)
	if Simula.running == true then
		Simula.trem.wheeljoint1:setMotorSpeed(15)
		--Simula.trem.wheeljoint2:setMotorSpeed(15)
		Simula.world:update(dt)
		Simula.matriz = Simula.criaMatrixG(Simula.conj)
	end
end

function Simula.draw(megaestado)
	Simula.drawBotao(megaestado)
	if Simula.running == true then
		print("ola");
		love.graphics.setColor(200, 156, 27);
		love.graphics.polygon("fill", Simula.trem.body:getWorldPoints(Simula.trem.shape:getPoints()))
		love.graphics.setColor(40, 46, 127);
		love.graphics.circle("line", Simula.wheel1.body:getX(), Simula.wheel1.body:getY(), Simula.wheel1.shape:getRadius())  
		love.graphics.circle("line", Simula.wheel2.body:getX(), Simula.wheel2.body:getY(), Simula.wheel2.shape:getRadius()) 		
	end
end

function Simula.criaMatrixG()
	local matrixGX = {}
	local matrixGY = {}
	local conj    = Simula.conj
	
	for i = 1, conj.nJuncoes do
		matrixGX[i] = {}
		matrixGY[i] = {}
	end

	for i = 1, conj.nJuncoes do
		for j = i, conj.nJuncoes do 
			matrixGX[i][j] = 0;
			matrixGY[i][j] = 0;
			local arestaij = conj.matrix[i][j];
			if  arestaij ~= nil then
				local dx = arestaij.j2.pos.x - arestaij.j1.pos.x;
				local dy = arestaij.j2.pos.y - arestaij.j1.pos.y;
				local hi = math.sqrt(dx*dx + dy*dy);
				local cosseno = dx/hi;
				local seno    = dy/hi;
				
				matrixGX[i][j] = cosseno;
				matrixGY[i][j] = seno;
			end
			if i ~= j then
				matrixGX[j][i] = - matrixGX[i][j];
				matrixGY[j][i] = - matrixGY[i][j];
			end
		end
	end

	return matrixGX, matrixGY;
end



