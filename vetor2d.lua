Vetor2D = {}

function Vetor2D.new(x, y)
	local vetor = {};
	
	vetor.x = x;
	vetor.y = y;
	
	if x == nil then
		vetor.x = 0;
	end
	if y == nil then
		vetor.y = 0;
	end

	return vetor;
end

function Vetor2D.distancia(v1, v2)
	local dx = v1.x - v2.x;
	local dy = v1.y - v2.y;

	return math.sqrt(dx*dx + dy*dy);
end