-- 1)
SELECT * FROM Venda
WHERE cliente in (1,2,3) AND date_format(data, '%Y%m')='201710';

-- 2)
SELECT T3.produto, T4.designacao, sum(T3.valor) FROM
(SELECT * 
FROM Cliente 
WHERE numero in (1,5)) AS T1
INNER JOIN Venda T2
ON T1.numero = T2.numero
INNER JOIN VendaProduto AS T3
ON T2.numero = T3.venda
INNER JOIN Produto AS T4
ON T3.produto = T4.numero
GROUP BY T3.produto, T4.designacao;

-- 3)
SELECT P.designacao AS Designacao, sum(VP.valor) AS Valor 
FROM Venda AS V
INNER JOIN VendaProduto AS VP
ON V.numero = VP.venda
INNER JOIN Produto AS P
ON VP.produto = P.numero
WHERE WEEK(V.data) = 3 AND YEAR(V.data) = 2018
GROUP BY P.designacao
ORDER BY 2 DESC LIMIT 3;

-- 4) conjunto de proddutos que não foram vendidos (que não estão na tabela vendaProduto)

-- em conjuntos
SELECT * FROM Produto AS P WHERE numero not in (
SELECT produto FROM VendaProduto);

-- com o operador exist
SELECT * FROM Produto AS P WHERE not exists (
SELECT * FROM VendaProduto AS VP WHERE P.numero = VP.produto);

-- 5)
select WEEK(a1.data), a3.designacao, sum(a2.valor) as valor, sum(a2.quantidade) as quantidade from Venda AS a1
inner join VendaProduto AS a2
ON a1.numero=a2.venda
inner join Produto AS a3 on a2.produto = a3.numero
where year(a1.data) = 2017 AND 
a2.produto = (select produto from
(SELECT Produto, sum(quantidade) from VendaProduto
inner join Venda on produto=numero
where YEAR(data) = '2017'
group by produto 
order by 2 desc limit 1) a1)
group by WEEK(a1.data), a3.designacao;


