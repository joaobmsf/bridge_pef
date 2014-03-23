require 'juncao'
require 'vetor2d'

Colisoes = {}


function Colisoes.mouseJuncoes(pos, conj) 
	for i = 1, conj.nJuncoes do
		local dis = Vetor2D.distancia(pos, conj.juncoes[i].pos);
		if dis <= Juncao.RAIO then
			return conj.juncoes[i];
		end
	end
	
	return nil;
end


function Colisoes.mouseAresta(pos, conj)
	for i = 1, conj.nJuncoes do
		for j = 1, i do
			if i ~= j and conj.matrix[i][j] ~= nil then
				local dista = Vetor2D.distanciaPontoReta(conj.juncoes[i].pos, conj.juncoes[j].pos, pos);
				local inter = Vetor2D.estaNoIntervalo(conj.juncoes[i].pos, conj.juncoes[j].pos, pos, Aresta.WIDTH/2.0);
				
				if dista <= Aresta.WIDTH/2.0 and inter == true then
					return conj.matrix[i][j];
				end
				
			end
		end
	end
	return nil;
end