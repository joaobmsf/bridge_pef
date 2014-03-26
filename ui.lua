require 'aresta'

Ui = {}

function Ui.drawBotao (situacao)
    if situacao == Aresta.CAMINHO then
        love.graphics.setColor(200, 200, 200);
    else
        love.graphics.setColor(80, 80, 80);
    end
    love.graphics.rectangle("fill", 90, 525, 80, 20);
    if situacao == Aresta.CAMINHO then
        love.graphics.setColor(255, 255, 255);
    else
        love.graphics.setColor(0, 0, 0);
    end
    love.graphics.print("Caminho",100,530);


    if situacao == Aresta.ESTRUTURA then
        love.graphics.setColor(142, 40, 40);
    else
        love.graphics.setColor(62, 0, 0);
    end
    love.graphics.rectangle("fill", 90, 555, 80, 20);
    if situacao == Aresta.ESTRUTURA then
        love.graphics.setColor(255, 255, 255);
    else
        love.graphics.setColor(0, 0, 0);
    end
    love.graphics.print("Estrutura",100,560);
end
