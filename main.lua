require 'juncao'
require 'aresta'
require 'vetor2d'
require 'testes'
require 'game'
require 'estagio'

function love.load() 
	Juncao.load();
	Aresta.load();
	--Game.load();
	
	love.graphics.setBackgroundColor(102, 178, 255);
	
	conj = Juncao.newConjunto();
    Estagio.load(1, conj);

    Juncao.imprime(conj);
end

function love.update(dt)
	--Game.update(dt);
end

function love.draw()
	--Game.draw();
	Estagio.draw(1, conj);
end

function love.mousereleased(x, y, button)
   Game.mousereleased(x, y, button);
end