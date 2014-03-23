require 'juncao'
require 'aresta'
require 'vetor2d'
require 'testes'
require 'colisoes'
require 'estagio'

Game = {}


function Game.load()
	Juncao.load();
	Aresta.load();
	
	Game.CRIANDO_ARESTA     = 1;
	Game.JUNCAO_SELECIONADA = 2;
	
	Game.estado = Game.CRIANDO_ARESTA;
	
	Game.level = 1;
	
	Game.lastClicked = nil;
	
	love.graphics.setBackgroundColor(102, 178, 255);
	
	Game.conj = Juncao.newConjunto();
	Estagio.load(Game.level, Game.conj);
	
	Juncao.imprime(Game.conj);
end

function Game.update(dt)
	if Game.estado == Game.CRIANDO_ARESTA and Game.lastClicked ~= nil then 
		local juncaoCol = Colisoes.mouseJuncoes(Game.lastClicked, Game.conj);
		if juncaoCol ~= nil then
			Game.juncaoSelecionada = juncaoCol;
			Game.estado = Game.JUNCAO_SELECIONADA;
		end
	elseif Game.estado == Game.JUNCAO_SELECIONADA and Game.lastClicked ~= nil then
		local juncaoCol = Colisoes.mouseJuncoes(Game.lastClicked, Game.conj);
		if juncaoCol ~= nil and juncaoCol ~= Game.juncaoSelecionada then
			Aresta.new(juncaoCol, Game.juncaoSelecionada, Aresta.ESTRUTURA);
			Game.estado = Game.CRIANDO_ARESTA;
			Game.juncaoSelecionada = nil;
			Game.lastClicked       = nil;
		end
	end
end

function Game.draw()
	Estagio.draw(Game.level);
	Juncao.drawConjunto(Game.conj);
	if Game.estado == Game.JUNCAO_SELECIONADA then
		love.graphics.setColor(255, 0, 0, 100);
		love.graphics.line(Game.juncaoSelecionada.pos.x, Game.juncaoSelecionada.pos.y, love.mouse.getX(), love.mouse.getY());
	end
end

function Game.mousereleased(x, y, button)
	if button == "l" then
		print("Mouse released");
		Game.lastClicked = Vetor2D.new(x, y);
	end
end
