require 'trem'
require 'aresta'

Simula = {}
Simula.TREM_P = 10000

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

    Simula.trem, Simula.wheel1, Simula.wheel2 = Trem.novo(Simula.world, pixelInMeter, edges);
	Simula.trem.pos = {x = 0, y = 0}
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
		Simula.world:update(dt*0.4)
		if Simula.conj.iAresta ~= nil then
			Simula.matrizGX, Simula.matrizGY = nil, nil;
			Simula.matrizGX, Simula.matrizGY = Simula.criaMatrixG(Simula.conj);
			print(Simula.matrizGX.teste.." "..Simula.matrizGY.teste);
			Simula.gauss(Simula.matrizGX, Simula.conj.arestas, 'x');
			Simula.gauss(Simula.matrizGY, Simula.conj.arestas, 'y');
		end
	end
end

function Simula.draw(megaestado)
	Simula.drawBotao(megaestado)
	if Simula.running == true then
		--print("ola");
		love.graphics.setColor(200, 156, 27);
		love.graphics.polygon("fill", Simula.trem.body:getWorldPoints(Simula.trem.shape:getPoints()))
		if Simula.trem.pos ~= nil then
			love.graphics.print(Simula.trem.body:getX().." "..Simula.trem.body:getY(),10,10);
		end
		love.graphics.setColor(40, 46, 127);
		love.graphics.circle("fill", Simula.wheel1.body:getX(), Simula.wheel1.body:getY(), Simula.wheel1.shape:getRadius())  
		love.graphics.circle("fill", Simula.wheel2.body:getX(), Simula.wheel2.body:getY(), Simula.wheel2.shape:getRadius()) 		
	end
end

function Simula.criaMatrixG()
	local matrixGX = {}
	local matrixGY = {}
	local conj    = Simula.conj
	matrixGX.teste = "lolX";
	matrixGY.teste = "lolY";
	
	--Cria matrizes X e Y
	for i = 1, conj.nJuncoes do
		matrixGX[i] = {}
		matrixGY[i] = {}
		
		for j = 1, conj.nArestas + 2 do
			matrixGX[i][j] = 0;
			matrixGY[i][j] = 0;
		end
		
		matrixGX[i][conj.nArestas+2] = 1;
	end
	
	print("Arestas");
	--Passa por todas as arestas
	for i = 1, conj.nArestas do 
		local aresta = conj.arestas[i];
		local j1 = aresta.j1.id;
		local j2 = aresta.j2.id;
		matrixGX[j1][i] = math.cos(aresta.ang);
		matrixGX[j2][i] = - matrixGX[j1][i];
		
		matrixGY[j1][i] = math.sin(aresta.ang);
		matrixGY[j2][i] = - matrixGY[j1][i];
		print(aresta.j1.id.." "..aresta.j2.id);
	end
	print("FIM Arestas");
	
	local firstJuncaoid = 4;
	local lastJuncaoid = 26;
	matrixGX[firstJuncaoid][conj.nArestas+1] =  1;
	matrixGX[lastJuncaoid][conj.nArestas+1]  = -1;
	
	local l = conj.juncoes[lastJuncaoid].pos.x - conj.juncoes[firstJuncaoid].pos.x;
	local x = Simula.trem.pos.x - conj.juncoes[firstJuncaoid].pos.x;
	
	matrixGY[firstJuncaoid][conj.nArestas+2] = Simula.TREM_P * (l - x)/l;
	matrixGY[lastJuncaoid][conj.nArestas+2]  = Simula.TREM_P * x/l;
	
	local lAresta = conj.iAresta.j2.pos.x - conj.iAresta.j1.pos.x;
	local xAresta = Simula.trem.pos.x - conj.iAresta.j1.pos.x;
	
	matrixGY[conj.iAresta.j1.id][conj.nArestas+2] = - Simula.TREM_P * (lAresta - xAresta)/lAresta;
	matrixGY[conj.iAresta.j2.id][conj.nArestas+2]  = - Simula.TREM_P * xAresta/lAresta;

	
	
	--imprimeMatrix(matrixGX);
	
	return matrixGX, matrixGY;
end

function imprimeMatrix(m) 
	print("Inicio impressao");
	for i = 1, #m do
		for j = 1, #(m[i]) do
			if m[i][j] ~= nil then
				io.write(m[i][j].." ");
			else
				io.write("# ");
			end
		end	
		io.write("\n");
	end
	print("Fim impressao");
end

function Simula.gauss(m, arestas, eixo)
	
	print("Entrando:");
		for ii = 1, #m do
			for jj = 1, #(m[ii]) do
				io.write(m[ii][jj].." ");
			end
			io.write("\n");
		end
	io.write("Fim\n");

	-- Triangularização com condenssação pivotal
	for i = 1, #(m[1]) - 2 do
	
		local indMaior = i;
		--print("Analisando o i: "..i);
		--Encontra o maior
		for j = i + 1, #m do 
			if( math.abs(m[j][i]) > math.abs(m[indMaior][i]) ) then indMaior = j end			
		end
		
		local maior = m[indMaior][i];
		--print("Maior encontrado"..maior)
		
		--Troca o maior com a linha i
		for j = i, #(m[i]) do
			local temp = m[i][j];
			m[i][j] = m[indMaior][j]/maior;
			if i ~= indMaior then m[indMaior][j] = temp; end
		end
		
		--[[print("Troca:");
			for ii = 1, #m do
				for jj = 1, #(m[ii]) do
					io.write(m[ii][jj].." ");
				end
				io.write("\n");
			end
		io.write("Fim\n");
		]]--
		-- Triangulariza
		if i >= #(m[1]) - 1 then
			for j = i + 1, #m do
				local maiorLocal = m[j][i];
				if maiorLocal ~= 0 then
						for k = i, #(m[j]) do
							m[j][k] = m[j][k]/maiorLocal - m[i][k];
						end
				end
				
				--[[print("Triangulariza:");
				for ii = 1, #m do
					for jj = 1, #(m[ii]) do
						io.write(m[ii][jj].." ");
					end
					io.write("\n");
				end
				io.write("Fim\n");]]--
			end
		end
	end
	
	-- Imprime matriz
	--[[for ii = 1, #m do
		for jj = 1, #(m[ii]) do
			io.write(m[ii][jj].." ");
		end
		io.write("\n");
	end]]--
	
	i = #(m[1]) - 1;
	while i ~= 0 do
		local vari = -m[i][#(m[i])];
		--print("VarI "..i.." "..vari);
		for j = i + 1, #(m[i]) - 1 do
			vari = vari - m[i][j]*m[j][#(m[i])];
		end
		if m[i][i] ~= 0 then m[i][#(m[i])] = vari/m[i][i]; else  m[i][#(m[i])] = 0 end
		i = i - 1;
	end
	
	for i = 1, #(m[1]) - 2 do
		if eixo == 'x'then
			arestas[i].forcax = m[i][#(m[i])];
		elseif eixo == 'y' then
			arestas[i].forcay = m[i][#(m[i])];
		end
		io.write(m[i][#(m[i])].." ");
	end
	io.write("\n");
end