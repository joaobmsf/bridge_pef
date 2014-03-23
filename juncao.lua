Juncao = {}

function Juncao.load()
	Juncao.nConjuntos = 0;
end


function Juncao.novoConjunto(linhas, colunas)
	local conjuntoJuncoes = {}
	
	conjuntoJuncoes.id       = Juncao.newConjuntoId();
	conjuntoJuncoes.nJuncoes = 0;
	conjuntoJuncoes.matrix   = {};
	conjuntoJuncoes.vazio    = true;
	
	return conjuntoJuncoes;
end