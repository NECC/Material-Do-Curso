-- 1) Quais são os clientes da mercearia?
SELECT * 
FROM Cliente;

-- 2) Quais são os nomes dos clientes que moram em 'Aguada do Queixo'?
SELECT nome
FROM Cliente
WHERE localidade = 'Aguada do Queixo';

-- 3) Quais são as profissões dos clientes da D. Acácia?
SELECT DISTINCT profissao 
FROM Cliente;

-- 4) Quais são os nomes dos produtos, e respetivos preço, que estão catalogados na base
-- de dados? Apresente-os ordenados alfabeticamente.
SELECT designacao, preco
FROM Produto
ORDER BY designacao ASC;

-- 5) Quais são os melhores clientes da mercearia?
SELECT Cliente.numero, nome, sum(total)
FROM Cliente
INNER JOIN Venda
ON Cliente.numero = Venda.cliente
GROUP BY Cliente.numero, Cliente.nome
ORDER BY 3 DESC 
LIMIT 3;

-- 6) Quais as vendas, e respetivos valores, que foram realizadas no dia '2017/10/05'?
SELECT numero, total 
FROM Venda
WHERE Date(data) = '2017/10/05';


-- 7) Quais foram os produtos mais vendidos durante a semana ‘40’?
SELECT designacao, sum(quantidade)
From Produto
INNER JOIN VendaProduto
ON VendaProduto.produto = Produto.Numero
INNER JOIN Venda
ON Venda.numero = VendaProduto.venda
WHERE WEEK(data) = '40'
GROUP BY designacao
ORDER BY 2 DESC;


-- 8) Qual o valor médio das vendas realizadas por dia da semana (segunda, terça, etc.)
SELECT DAYNAME(data),AVG(total)
FROM Venda
GROUP BY DAYNAME(data);
