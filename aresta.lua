require 'juncao'

Aresta = {}

function Aresta.load()
	Aresta.n = 0;
	Aresta.WIDTH = 5;
	Aresta.CAMINHO   = 1;
	Aresta.ESTRUTURA = 2;
end


function Aresta.atualizaN()
	Aresta.n = Aresta.n + 1
end

function Aresta.getNewId()
	Aresta.atualizaN();
	
	return Aresta.n;
end

--[[
	Cria uma nova aresta que está entre juncao1 e juncao2 
	Tem o tipo que pode ser:
		"caminho"   - onde o trem pode colidir
		"estrutura" - o trem não colide
	
	Por fim linka a aresta ao conjunto das juncoes
	OBS:: Pre-requisitos nao conferidos:
		juncao1 e juncao2 devem ter o mesmo conjunto;
--]]
function Aresta.new(juncao1, juncao2, tipo)
	local aresta = {}
	aresta.id = Aresta.getNewId();
	aresta.tipo = tipo;
	aresta.j1 = juncao1;
	aresta.j2 = juncao2;
	
	Juncao.addAresta(aresta, juncao1.conjunto);
	
	return aresta;
end

function Aresta.draw(aresta, color)
	love.graphics.setLineWidth(Aresta.WIDTH);
	if color ~= nil then
		love.graphics.setColor(color);	
	elseif aresta.tipo == Aresta.ESTRUTURA then
		love.graphics.setColor(102, 0, 0);	
	elseif aresta.tipo == Aresta.CAMINHO then
		love.graphics.setColor(160, 160, 160);
	else
		print("ERROR Aresta.draw: tipo inexistente");	
	end
	
	local x1 = aresta.j1.pos.x;
	local y1 = aresta.j1.pos.y;
	local x2 = aresta.j2.pos.x;
	local y2 = aresta.j2.pos.y;
	
	love.graphics.line(x1, y1, x2, y2);	
end

function Aresta.mudarTipo(aresta, tipo)
	print("Ola");

	aresta.tipo = tipo;
end

function Aresta.del(aresta)
	local conj = aresta.j1.conjunto;
	conj.matrix[aresta.j1.id][aresta.j2.id] = nil;
	conj.matrix[aresta.j2.id][aresta.j1.id] = nil;
end
