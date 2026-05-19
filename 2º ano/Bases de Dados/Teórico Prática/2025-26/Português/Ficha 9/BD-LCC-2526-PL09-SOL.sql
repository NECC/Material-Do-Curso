-- ============================================================
--  BD-LCC-2526 | PL09 — Resolução
--  Tema: SQL — Gestão de Utilizadores, Roles, Permissões e Views
--  Base de dados: sakila
-- ============================================================

USE sakila;

-- ============================================================
-- PARTE I — Gestão de Utilizadores
-- ============================================================

-- ------------------------------------------------------------
-- 1. Criar utilizadores user_leitura e analista
--    (acesso apenas a partir do localhost; password inicial: 1234)
-- ------------------------------------------------------------
CREATE USER 'user_leitura'@'localhost' IDENTIFIED BY '1234';
CREATE USER 'analista'@'localhost'     IDENTIFIED BY '1234';


-- ------------------------------------------------------------
-- 2. Alterar user_leitura: nova password mais segura
--    e expiração ao fim de 90 dias.
-- ------------------------------------------------------------
ALTER USER 'user_leitura'@'localhost'
    IDENTIFIED BY 'P@ssw0rd_Segura!'
    PASSWORD EXPIRE INTERVAL 90 DAY;


-- ------------------------------------------------------------
-- 3. Listar todos os utilizadores existentes no sistema MySQL.
-- ------------------------------------------------------------
SELECT user, host
FROM mysql.user;


-- ============================================================
-- PARTE II — Roles
-- ============================================================

-- ------------------------------------------------------------
-- 4. Criar as roles leitor e editor.
-- ------------------------------------------------------------
CREATE ROLE 'leitor';
CREATE ROLE 'editor';


-- ------------------------------------------------------------
-- 5. Atribuir a role leitor ao utilizador user_leitura.
-- ------------------------------------------------------------
GRANT 'leitor' TO 'user_leitura'@'localhost';


-- ============================================================
-- PARTE III — Permissões
-- ============================================================

-- ------------------------------------------------------------
-- 6. Permissões de leitura sobre toda a base de dados sakila
--    à role leitor.
-- ------------------------------------------------------------
GRANT SELECT ON sakila.* TO 'leitor';


-- ------------------------------------------------------------
-- 7. Permissões de leitura, inserção e atualização nas tabelas
--    customer e rental à role editor.
-- ------------------------------------------------------------
GRANT SELECT, INSERT, UPDATE ON sakila.customer TO 'editor';
GRANT SELECT, INSERT, UPDATE ON sakila.rental   TO 'editor';


-- ------------------------------------------------------------
-- 8. Atribuir a role editor ao utilizador analista.
-- ------------------------------------------------------------
GRANT 'editor' TO 'analista'@'localhost';


-- ------------------------------------------------------------
-- 9. Definir a role editor como role ativa por defeito
--    do utilizador analista.
-- ------------------------------------------------------------
SET DEFAULT ROLE 'editor' TO 'analista'@'localhost';


-- ------------------------------------------------------------
-- 10. Remover a permissão de atualização da role editor
--     para a tabela customer.
-- ------------------------------------------------------------
REVOKE UPDATE ON sakila.customer FROM 'editor';


-- ============================================================
-- PARTE IV — Vistas
-- ============================================================

-- ------------------------------------------------------------
-- 11. View vw_clientes: id, primeiro nome, último nome e email.
-- ------------------------------------------------------------
CREATE VIEW vw_clientes AS
SELECT customer_id,
       first_name,
       last_name,
       email
FROM customer;


-- ------------------------------------------------------------
-- 12. View vw_filmes: título do filme e respetiva categoria.
-- ------------------------------------------------------------
CREATE VIEW vw_filmes AS
SELECT f.title,
       c.name AS categoria
FROM film f
JOIN film_category fc ON f.film_id      = fc.film_id
JOIN category      c  ON fc.category_id = c.category_id;


-- ------------------------------------------------------------
-- 13. View vw_rentals_ativos: alugueres ainda não devolvidos
--     (return_date IS NULL).
-- ------------------------------------------------------------
CREATE VIEW vw_rentals_ativos AS
SELECT *
FROM rental
WHERE return_date IS NULL;


-- ------------------------------------------------------------
-- 14. View vw_top_clientes: id, nome completo e total de
--     alugueres por cliente, ordenado do maior para o menor.
-- ------------------------------------------------------------
CREATE VIEW vw_top_clientes AS
SELECT c.customer_id,
       CONCAT(c.first_name, ' ', c.last_name) AS nome,
       COUNT(r.rental_id)                      AS total_alugueres
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_alugueres DESC;


-- ------------------------------------------------------------
-- 15. Role relatorio com SELECT apenas sobre vw_clientes;
--     atribuída ao utilizador viewer.
-- ------------------------------------------------------------
CREATE ROLE 'relatorio';
GRANT SELECT ON sakila.vw_clientes TO 'relatorio';

-- Criar o utilizador viewer (caso ainda não exista)
CREATE USER 'viewer'@'localhost' IDENTIFIED BY '1234';
GRANT 'relatorio' TO 'viewer'@'localhost';
