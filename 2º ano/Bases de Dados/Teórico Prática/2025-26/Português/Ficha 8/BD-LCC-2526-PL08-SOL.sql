-- ============================================================
--  BD-LCC-2526 | PL08 — Resolução
--  Tema: SQL (SELECT) — Base de dados entrega_comida
-- ============================================================

USE entrega_comida;

-- ------------------------------------------------------------
-- 1. Nome e contacto de todos os estafetas, ordenados pelo
--    nome de forma ascendente.
-- ------------------------------------------------------------
SELECT nome, contacto
FROM Estafeta
ORDER BY nome ASC;


-- ------------------------------------------------------------
-- 2. Designação e preço por dose de todos os pratos do tipo
--    'entrada'.
-- ------------------------------------------------------------
SELECT designacao, preco_dose
FROM Prato
WHERE tipo = 'entrada';


-- ------------------------------------------------------------
-- 3. Dados completos dos clientes cujo código postal começa
--    por '47'.
-- ------------------------------------------------------------
SELECT *
FROM Cliente
WHERE cod_postal LIKE '47%';


-- ------------------------------------------------------------
-- 4. Pedidos com preço entre 10 € e 50 €, ordenados do mais
--    caro para o mais barato. Apenas os 3 mais caros.
-- ------------------------------------------------------------
SELECT *
FROM Pedido
WHERE preco BETWEEN 10 AND 50
ORDER BY preco DESC
LIMIT 3;


-- ------------------------------------------------------------
-- 5. Nomes únicos dos clientes que fizeram pelo menos um
--    pedido depois de 1 de janeiro de 2024.
-- ------------------------------------------------------------
SELECT DISTINCT c.nome
FROM Cliente c
JOIN Pedido p ON c.idCliente = p.idCliente
WHERE p.data_pedido > '2024-01-01';


-- ------------------------------------------------------------
-- 6. Designação do prato, dose e preço de cada item de pedido,
--    apenas para pratos do tipo 'prato principal' ou 'sobremesa'.
-- ------------------------------------------------------------
SELECT pr.designacao, ip.dose, ip.preco
FROM Item_pedido ip
JOIN Prato pr ON ip.idPrato = pr.idPrato
WHERE pr.tipo IN ('prato principal', 'sobremesa');


-- ------------------------------------------------------------
-- 7. Nome do cliente, data do pedido e nome do estafeta,
--    apenas para pedidos com estafeta atribuído realizados
--    durante o ano de 2025.
-- ------------------------------------------------------------
SELECT c.nome       AS cliente,
       p.data_pedido,
       e.nome       AS estafeta
FROM Pedido p
JOIN Cliente  c ON p.idCliente  = c.idCliente
JOIN Estafeta e ON p.idEstafeta = e.idEstafeta
WHERE YEAR(p.data_pedido) = 2025;


-- ------------------------------------------------------------
-- 8. Quantos pedidos existem na base de dados?
--    Alias: total_pedidos
-- ------------------------------------------------------------
SELECT COUNT(*) AS total_pedidos
FROM Pedido;


-- ------------------------------------------------------------
-- 9. Preço médio (arredondado a 2 casas decimais) e preço
--    máximo dos pratos.
--    Aliases: preco_medio, preco_maximo
-- ------------------------------------------------------------
SELECT ROUND(AVG(preco_dose), 2) AS preco_medio,
       MAX(preco_dose)           AS preco_maximo
FROM Prato;


-- ------------------------------------------------------------
-- 10. Número de pedidos por cliente.
--     Apenas clientes com mais de 1 pedido.
-- ------------------------------------------------------------
SELECT c.nome, COUNT(*) AS num_pedidos
FROM Pedido p
JOIN Cliente c ON p.idCliente = c.idCliente
GROUP BY c.idCliente, c.nome
HAVING COUNT(*) > 1;


-- ------------------------------------------------------------
-- 11. Valor total faturado por cada estafeta, com o nome do
--     estafeta. Ordenado do maior para o menor.
-- ------------------------------------------------------------
SELECT e.nome, SUM(p.preco) AS total_faturado
FROM Pedido p
JOIN Estafeta e ON p.idEstafeta = e.idEstafeta
GROUP BY e.idEstafeta, e.nome
ORDER BY total_faturado DESC;


-- ------------------------------------------------------------
-- 12. Dados dos clientes que nunca realizaram nenhum pedido.
-- ------------------------------------------------------------
-- Opção A — subconsulta NOT IN
SELECT *
FROM Cliente
WHERE idCliente NOT IN (SELECT idCliente FROM Pedido);

-- Opção B — LEFT JOIN
SELECT c.*
FROM Cliente c
LEFT JOIN Pedido p ON c.idCliente = p.idCliente
WHERE p.idPedido IS NULL;


-- ------------------------------------------------------------
-- 13. Pratos que já foram incluídos em algum pedido.
-- ------------------------------------------------------------
-- Opção A — subconsulta IN
SELECT *
FROM Prato
WHERE idPrato IN (SELECT idPrato FROM Item_pedido);

-- Opção B — JOIN com DISTINCT
SELECT DISTINCT pr.*
FROM Prato pr
JOIN Item_pedido ip ON pr.idPrato = ip.idPrato;


-- ------------------------------------------------------------
-- 14. Lista única com as localidades de todos os clientes e
--     as localidades de todos os pedidos. Sem duplicados.
-- ------------------------------------------------------------
SELECT localidade
FROM Cliente
UNION
SELECT c.localidade
FROM Pedido p
JOIN Cliente c ON p.idCliente = c.idCliente;
