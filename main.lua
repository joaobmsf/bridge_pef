require 'juncao'
require 'aresta'
require 'vetor2d'
require 'testes'

function love.load() 
	Juncao.load();
	Aresta.load();
	
	love.graphics.setBackgroundColor(102, 178, 255);
	
	conj = Juncao.newConjunto();
	local jun1 = Juncao.new(Vetor2D.new(100, 100), Juncao.FIXA, conj);
	local jun2 = Juncao.new(Vetor2D.new(200, 100), Juncao.FIXA, conj);
	local jun3 = Juncao.new(Vetor2D.new(100, 200), Juncao.LIVRE, conj);
	local jun4 = Juncao.new(Vetor2D.new(200, 200), Juncao.FIXA, conj);
	Aresta.new(jun1, jun2, Aresta.ESTRUTURA);
	Aresta.new(jun2, jun3, Aresta.CAMINHO);
	Aresta.new(jun3, jun4, Aresta.ESTRUTURA);
	
	Juncao.imprime(conj);
end

function love.update(dt)


end

function love.draw()
	Juncao.drawConjunto(conj);
end