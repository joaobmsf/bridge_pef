require 'juncao'
require 'aresta'

Estagio = {}

--[[
    Estagio.load cria a rede de junções para o level, e gera um caminho na colina, de modo que o trem ande por ela.
]]--

function Estagio.load(level)
    local jun = {}
    local n = 0
    if level == 1 then
    
        jun[0] = Juncao.new(Vetor2D.new(0, 300), Juncao.FIXA, conj);
        n = 1
        for x = 0, 8 do
            for y = 0, 10 do
                if (x == 0 and y>=6) or (x == 8 and y>=4) or (y == 10)then
                    jun[n] = Juncao.new(Vetor2D.new(200 + (x*50), y*50), Juncao.FIXA, conj);
                else
                    jun[n] = Juncao.new(Vetor2D.new(200 + (x*50), y*50), Juncao.LIVRE, conj);
                end
                n = n + 1;
            end
        end
        jun[n] = Juncao.new(Vetor2D.new(800, 200), Juncao.FIXA, conj);
        
        Aresta.new(jun[0], jun[7], Aresta.ESTRUTURA);
        Aresta.new(jun[n-7], jun[n], Aresta.ESTRUTURA);
    
    end
end

--[[
    Estagio.draw imprime os pontos de junção e as colinas, conforme o level desejado
]]--

function Estagio.draw(level)
    Juncao.drawConjunto(conj);
    if level == 1 then
        love.graphics.setColor(0, 155, 0);
        love.graphics.rectangle("fill", 0, 300, 200, 300);
        love.graphics.rectangle("fill", 200, 500, 400, 100);
        love.graphics.rectangle("fill", 600, 200, 200, 400);
    elseif level == 2 then
        love.graphics.setColor(0, 255, 0);
        love.graphics.rectangle("fill", 0, 300, 200, 300);
        love.graphics.rectangle("fill", 200, 500, 400, 100);
        love.graphics.rectangle("fill", 600, 200, 200, 400);
    end
end

