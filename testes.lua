require 'juncao'
require 'aresta'
require 'vetor2d'

Testes = {}

function Testes.teste1()

	local v = Vetor2D.new();
	local conj = Juncao.newConjunto();
	print(v.x, v.y);
	local jun  = Juncao.new(v, "fixa", conj);
	local jun2 = Juncao.new(v, "livre", conj);
	local jun3 = Juncao.new(v, "livre", conj);
	local jun4 = Juncao.new(v, "livre", conj);
	local jun5 = Juncao.new(v, "livre", conj);
	local edge = Aresta.new(jun, jun2);
	local edge = Aresta.new(jun5, jun4);
	local edge = Aresta.new(jun3, jun4);
	print("Conjunto id: "..conj.id);
	print("Conjunto id primeira juncao: "..conj.juncoes[1].id);
	print("Conjunto id segunda  juncao: "..conj.juncoes[2].id);
	print("Aresta entre jun e jun2: "..conj.matrix[2][1].id);
	Juncao.imprime(conj);

end