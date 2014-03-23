require 'juncao'
require 'aresta'
require 'vetor2d'
require 'testes'
require 'game'
require 'estagio'
require 'simula'

function love.load() 
	Game.load();
end

function love.update(dt)
	Game.update(dt);
end

function love.draw()
	Game.draw();
end

function love.mousereleased(x, y, button)
   Game.mousereleased(x, y, button);
end

function love.keypressed(key, isrepeat)
	Game.keypressed(key, isrepeat);
end