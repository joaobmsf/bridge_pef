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
	for i = 2, conj.nJuncoes - 1 do
		for j = 2, i do
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

function Colisoes.mouseBotao(pos)
    -- Botão de simulação
    
    if pos ~= nil then
        if pos.x >= 25 and pos.x <= 75 and pos.y >=525 and pos.y <=575 then
            return 1;
        end
    end
    -- Botão de Caminho
    if pos ~= nil then
        if pos.x >= 90 and pos.x <= 170 and pos.y >=525 and pos.y <=550 then
            return 2;
        end
    end
    -- Botão de Estrutura
    if pos ~= nil then
        if pos.x >= 90 and pos.x <= 170 and pos.y >=555 and pos.y <=575 then
            return 3;
        end
    end
    return 0;
end