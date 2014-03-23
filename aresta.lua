require 'juncao'

Aresta = {}

function Aresta.load()
	Aresta.n = 0;
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
