require 'juncao'
require 'aresta'
require 'vetor2d'
require 'testes'
require 'colisoes'
require 'estagio'
require 'simula'
require 'ui'

Game = {}


function Game.load()
	Juncao.load();
	Aresta.load();

    -- estados possiveis no jogo
    Game.CONSTRUCAO = 1;
    Game.SIMULACAO = 2;
    
    -- estados possiveis na simulacao
	Game.CRIANDO_ARESTA     = 1;
	Game.JUNCAO_SELECIONADA = 2;
	Game.ARESTA_SELECIONADA = 3;
	Game.SIMULA_SELECIONADO = 4;

	Game.megaEstado = Game.CONSTRUCAO;
	Game.estado = Game.CRIANDO_ARESTA;
	
    Game.tipoAresta = Aresta.ESTRUTURA;
    

	Game.level = 1;
	Game.maxAresta = 50*math.sqrt(2);
	
	Game.lastClicked       = nil;
	Game.arestaSelecionada = nil;
	Game.juncaoSelecionada = nil;
	
	love.graphics.setBackgroundColor(102, 178, 255);
	
	Game.conj = Juncao.newConjunto();
	Estagio.load(Game.level, Game.conj);
	
	Juncao.imprime(Game.conj);
end

function Game.update(dt)
    if Game.megaEstado == Game.CONSTRUCAO then
        Game.construcaoUp (dt)
    else
        Game.simulacaoUp (dt)
    end
end

function Game.simulacaoUp (dt)
    botaoCol = Colisoes.mouseBotao(Game.lastClicked);
    if botaoCol == 1 then
        Game.megaEstado = Game.CONSTRUCAO
        Game.lastClicked = nil
    end
    Simula.update(dt);

    Game.iAresta = Simula.verificaAresta(Game.conj);
end

function Game.construcaoUp (dt)
    local t
    botaoCol = Colisoes.mouseBotao(Game.lastClicked);
    if botaoCol == 1 then
        local play = Simula.verificaPlay(Game.conj);
        if play == 1 then
            Game.megaEstado = Game.SIMULACAO;
			Simula.inicia(Game.conj);
            Game.lastClicked = nil
        end
    elseif botaoCol == 2 then
        Game.tipoAresta = Aresta.CAMINHO;
    elseif botaoCol == 3 then
        Game.tipoAresta = Aresta.ESTRUTURA;
    end

	if Game.estado == Game.CRIANDO_ARESTA and Game.lastClicked ~= nil then
		-- Verifica se o ultimo clique foi em uma juncao
		local juncaoCol = Colisoes.mouseJuncoes(Game.lastClicked, Game.conj);
		if juncaoCol ~= nil then
			Game.juncaoSelecionada = juncaoCol;
			Game.estado = Game.JUNCAO_SELECIONADA;
		else -- verifica se o ultimo clique foi em uma aresta		
			local arestaCol = Colisoes.mouseAresta(Game.lastClicked, Game.conj);
			if arestaCol ~= nil then
				Game.arestaSelecionada = arestaCol;
				Game.estado = Game.ARESTA_SELECIONADA;
			end
		end
		
	elseif Game.estado == Game.JUNCAO_SELECIONADA and Game.lastClicked ~= nil then
		local juncaoCol = Colisoes.mouseJuncoes(Game.lastClicked, Game.conj);
		if juncaoCol ~= nil and juncaoCol ~= Game.juncaoSelecionada then
			if Game.conj.matrix[juncaoCol.id][Game.juncaoSelecionada.id] == nil
			   and Vetor2D.distancia(juncaoCol.pos, Game.juncaoSelecionada.pos) <= Game.maxAresta then
				Aresta.new(juncaoCol, Game.juncaoSelecionada, Game.tipoAresta);
				Game.estado = Game.CRIANDO_ARESTA;
				Game.juncaoSelecionada = nil;
				Game.lastClicked       = nil;
			end
		end
		
	elseif Game.estado == Game.ARESTA_SELECIONADA and Game.lastClicked ~= nil then
		local juncaoCol = Colisoes.mouseJuncoes(Game.lastClicked, Game.conj);
		if juncaoCol ~= nil then
			Game.juncaoSelecionada = juncaoCol;
			Game.estado = Game.JUNCAO_SELECIONADA;
		else -- verifica se o ultimo clique foi em uma aresta		
			local arestaCol = Colisoes.mouseAresta(Game.lastClicked, Game.conj);
			if arestaCol ~= nil then
				Game.arestaSelecionada = arestaCol;
				Game.estado = Game.ARESTA_SELECIONADA;
			end
		end	
		Game.lastClicked = nil;
	end
end


function Game.draw()
	Estagio.draw(Game.level);
    Simula.draw(Game.megaEstado)
    Juncao.drawAresta(Game.conj);
	if Game.iAresta ~= nil then
	Aresta.draw(Game.iAresta, {255, 0, 0});
	end
	if Game.megaEstado == Game.CONSTRUCAO then
        Juncao.drawJuncao(Game.conj);
        Ui.drawBotao(Game.tipoAresta)
		if Game.estado == Game.JUNCAO_SELECIONADA then
			love.graphics.setColor(255, 0, 0, 100);
			local dista = math.sqrt(math.pow((Game.juncaoSelecionada.pos.x - love.mouse.getX()),2)+math.pow((Game.juncaoSelecionada.pos.y - love.mouse.getY()),2))
			if dista <= Game.maxAresta then
				love.graphics.line(Game.juncaoSelecionada.pos.x, Game.juncaoSelecionada.pos.y, love.mouse.getX(), love.mouse.getY());
			else
				local angulo = math.atan2(Game.juncaoSelecionada.pos.y - love.mouse.getY(), Game.juncaoSelecionada.pos.x - love.mouse.getX());
				love.graphics.line(Game.juncaoSelecionada.pos.x, Game.juncaoSelecionada.pos.y, Game.juncaoSelecionada.pos.x - Game.maxAresta*math.cos(angulo), Game.juncaoSelecionada.pos.y - Game.maxAresta*math.sin(angulo));
			end
		elseif Game.estado == Game.ARESTA_SELECIONADA then
			Aresta.draw(Game.arestaSelecionada, {255, 0, 0});		
		end
	end
end

function Game.mousereleased(x, y, button)
	if button == "l" then
		print("Mouse released");
		Game.lastClicked = Vetor2D.new(x, y);
	end
end

function Game.keypressed(key, isrepeat)
	
	if isrepeat == false then
		if Game.megaEstado == Game.CONSTRUCAO then
			if Game.estado == Game.ARESTA_SELECIONADA then
				if key == "delete" then
					Aresta.del(Game.arestaSelecionada);
					Game.estado = Game.CRIANDO_ARESTA;
					Game.lastClicked = nil;
				elseif key == " " then
					if Game.arestaSelecionada.tipo == Aresta.CAMINHO then
						Aresta.mudarTipo(Game.arestaSelecionada, Aresta.ESTRUTURA);
					elseif Game.arestaSelecionada.tipo == Aresta.ESTRUTURA then
						Aresta.mudarTipo(Game.arestaSelecionada, Aresta.CAMINHO);
					end
					Game.estado = Game.CRIANDO_ARESTA;
					Game.lastClicked = nil;
				elseif key == "escape" then
						Game.estado = Game.CRIANDO_ARESTA;
						Game.lastClicked = nil;							
				end
			elseif Game.estado == Game.JUNCAO_SELECIONADA then
				if key == "escape" then
					print("ola");
					Game.estado = Game.CRIANDO_ARESTA;
					Game.lastClicked = nil;
				end	
			end
		end
	end
end
