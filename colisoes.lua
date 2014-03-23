require 'juncao'
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