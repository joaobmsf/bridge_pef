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

--[[
	p1 e p2 são os pontos que definem a reta;
	p é o ponto que quero ver a distancia;
]]--
function Vetor2D.distanciaPontoReta(p1, p2, p)
	local A = 0;
	local B = 1;
	local C = -p1.y;
	if p1.y ~= p2.y then
		A = 1;
		B = -(p1.x - p2.x)/(p1.y - p2.y);
		C = - p1.x - B*p1.y;
	end
	local dis = math.abs(A*p.x + B*p.y + C)/math.sqrt(A*A +B*B);
	
	return dis;
end


function Vetor2D.estaNoIntervalo(p1, p2, p, tol)
	local xmin = math.min(p1.x, p2.x) - tol;
	local ymin = math.min(p1.y, p2.y) - tol;
	local xmax = math.max(p1.x, p2.x) + tol;
	local ymax = math.max(p1.y, p2.y) + tol;
	
	return p.x <= xmax and p.x >= xmin and p.y <= ymax and p.y >= ymin;
end