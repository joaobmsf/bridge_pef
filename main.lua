require 'juncao'
require 'aresta'
require 'vetor2d'
require 'testes'
require 'estagio'

function love.load() 
	Juncao.load();
	Aresta.load();
	
	love.graphics.setBackgroundColor(102, 178, 255);
	
	conj = Juncao.newConjunto();
    Estagio.load(1);

    Juncao.imprime(conj);
end

function love.update(dt)


end

function love.draw()
    Estagio.draw(1);

end