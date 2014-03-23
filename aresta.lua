Aresta = {}

function Aresta.load()
	Aresta.n = 0;
end


function Aresta.atualizaN()
	Aresta.n = Aresta
end

function Aresta.getNewID()
	local id = Aresta.n;
	Aresta.atualizaN();
	
	return id;
end

function Aresta.new(juncao1, juncao2)
	local aresta = {}
	aresta.id = Aresta.getNewID();
	aresta.j1 = juncao1;
	aresta.j2 = juncao2;

	return aresta;
end
