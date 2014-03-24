Juncao = {}

function Juncao.load()
	Juncao.nConjuntos = 0;
	Juncao.FIXA  = 1;
	Juncao.LIVRE = 2;
	Juncao.RAIO  = 5;
end

function Juncao.newConjuntoId()
	Juncao.nConjuntos = Juncao.nConjuntos + 1;
	
	return Juncao.nConjuntos;
end

function Juncao.newConjunto()
	local conjuntoJuncoes = {}
	
	conjuntoJuncoes.id       = Juncao.newConjuntoId();
	conjuntoJuncoes.nJuncoes = 0;
	conjuntoJuncoes.juncoes  = {}
	conjuntoJuncoes.arestas  = {}
	conjuntoJuncoes.matrix   = {};
	conjuntoJuncoes.vazio    = true;
	
	return conjuntoJuncoes;
end

--[[
	Conjunto de juncoes que vai fornecer o novo id da juncao
]]--
function Juncao.getNewId(conjunto)
	conjunto.nJuncoes = conjunto.nJuncoes + 1;
	
	return conjunto.nJuncoes;
end

--[[ 
	Adiciona a juncao no conjunto
	Cria um id para juncao
	Linka a juncao com o conjunto 
]]--
function Juncao.add(juncao, conjunto)
	juncao.id                   = Juncao.getNewId(conjunto);
	juncao.conjunto             = conjunto;
	conjunto.juncoes[juncao.id] = juncao;
	conjunto.matrix[juncao.id]  = {};
	conjunto.vazio = false;
end

function Juncao.addAresta(aresta, conjunto)
	local id1 = aresta.j1.id;
	local id2 = aresta.j2.id;
	
	conjunto.matrix[id1][id2] = aresta;
	conjunto.matrix[id2][id1] = aresta;
	conjunto.aresta[aresta.id] = aresta;
end

--[[ 
pos é um vetor(x,y) que tem a posicao da juncao;
tipo é o tipo que de juncao, podendo ser:
	"livre"    - connecta varias arestas.
	"fixa"     - se connecta a arestas e a uma "parede"
conjunto é o conjunto que a juncao pertence;
]]--
function Juncao.new(pos, tipo, conjunto)
	local juncao = {};
	
	juncao.pos  = pos;
	juncao.tipo = tipo;
	Juncao.add(juncao, conjunto);
	
	return juncao;
end

function Juncao.imprime(conjunto)
	for i = 1, conjunto.nJuncoes do
		for j = 1, conjunto.nJuncoes do
			if i == j or conjunto.matrix[i][j] == nil then
				io.write("# ");
			else 
				io.write(conjunto.matrix[i][j].id.." ");
			end
		end	
		io.write("\n");
	end
end

function Juncao.draw(juncao)
	if juncao.tipo == Juncao.FIXA then
		love.graphics.setColor(0, 0, 0);	
	elseif juncao.tipo == Juncao.LIVRE then
		love.graphics.setColor(255, 102, 102);
	else
		print("ERROR Juncao.draw: tipo inexistente");	
	end
	
	love.graphics.circle("fill", juncao.pos.x, juncao.pos.y, Juncao.RAIO);	
end

function Juncao.drawConjunto(conjunto)
	for i = 1, conjunto.nJuncoes do
		for j = 1, i do
			if i ~= j and conjunto.matrix[i][j] ~= nil then
				Aresta.draw(conjunto.matrix[i][j]);
			end
		end
	end
	for i = 1, conjunto.nJuncoes do
		Juncao.draw(conjunto.juncoes[i]);
	end
end