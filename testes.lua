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
	local edge = Aresta.new(jun, jun2);
	print("Conjunto id: "..conj.id);
	print("Conjunto id primeira juncao: "..conj.juncoes[1].id);
	print("Conjunto id segunda  juncao: "..conj.juncoes[2].id);
	print("Aresta entre jun e jun2: "..conj.matrix[2][1].id);

end