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