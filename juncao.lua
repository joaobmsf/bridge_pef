Juncao = {}

function Juncao.load()
	Juncao.nConjuntos = 0;
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
	conjuntoJuncoes.matrix   = {};
	conjuntoJuncoes.vazio    = true;
	
	return conjuntoJuncoes;
end

--[[
	Conjunto de juncoes que vai fornecer o novo id da juncao
]]--
function Juncao.getNewId(conjunto)
	conjunto.nJuncoes = conjunto.nJuncoes + 1;
	
	return id;
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