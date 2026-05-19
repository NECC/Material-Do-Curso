-- ============================================================
--  BD-LCC-2526 | PL10 — Resolução
--  Tema: SQL — Índices, Prepared Statements, Procedimentos,
--             Funções, Gatilhos, Transações
--  Base de dados: sakila
-- ============================================================

USE sakila;

-- ============================================================
-- 1. Índice na coluna payment_date da tabela payment.
-- ============================================================

CREATE INDEX idx_payment_date ON payment(payment_date);


-- ============================================================
-- 2. Prepared statement que devolve o nome dos clientes
--    de cada loja. Execução para a loja 1.
-- ============================================================

PREPARE stmt_clientes_loja FROM
    'SELECT first_name, last_name FROM customer WHERE store_id = ?';

SET @loja = 1;
EXECUTE stmt_clientes_loja USING @loja;

DEALLOCATE PREPARE stmt_clientes_loja;


-- ============================================================
-- 3. Procedimento filmes_por_categoria
--    Recebe o ID de uma categoria e devolve os títulos
--    dos filmes dessa categoria.
-- ============================================================

DELIMITER $$

CREATE PROCEDURE filmes_por_categoria(IN p_categoria_id INT)
BEGIN
    SELECT f.title
    FROM film f
    JOIN film_category fc ON f.film_id      = fc.film_id
    WHERE fc.category_id = p_categoria_id;
END$$

DELIMITER ;

-- Execução para a categoria 1 (Action)
CALL filmes_por_categoria(1);


-- ============================================================
-- 4. Procedimento ultimo_pagamento_cliente
--    Recebe um customer_id e devolve a data do último pagamento.
-- ============================================================

DELIMITER $$

CREATE PROCEDURE ultimo_pagamento_cliente(IN p_customer_id INT)
BEGIN
    SELECT MAX(payment_date) AS ultimo_pagamento
    FROM payment
    WHERE customer_id = p_customer_id;
END$$

DELIMITER ;

-- Execução para o cliente 1
CALL ultimo_pagamento_cliente(1);


-- ============================================================
-- 5. Função total_filmes_ator
--    Recebe o ID de um ator e devolve o número de filmes.
-- ============================================================

DELIMITER $$

CREATE FUNCTION total_filmes_ator(p_actor_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total
    FROM film_actor
    WHERE actor_id = p_actor_id;
    RETURN total;
END$$

DELIMITER ;

-- Execução para o ator 1
SELECT total_filmes_ator(1) AS num_filmes;


-- ============================================================
-- 6. Trigger: após INSERT em payment, atualiza total_spent
--    na tabela customer.
--
--    A coluna total_spent não existe no esquema Sakila padrão;
--    é necessário adicioná-la primeiro.
-- ============================================================

ALTER TABLE customer
    ADD COLUMN total_spent DECIMAL(10,2) NOT NULL DEFAULT 0.00;

DELIMITER $$

CREATE TRIGGER trg_atualiza_total_spent
AFTER INSERT ON payment
FOR EACH ROW
BEGIN
    UPDATE customer
    SET total_spent = total_spent + NEW.amount
    WHERE customer_id = NEW.customer_id;
END$$

DELIMITER ;


-- ============================================================
-- 7. Transação: ativa um cliente (active = 1) e insere
--    um pagamento. Termina com COMMIT.
-- ============================================================

START TRANSACTION;

    UPDATE customer
    SET active = 1
    WHERE customer_id = 1;

    INSERT INTO payment (customer_id, staff_id, rental_id, amount, payment_date)
    VALUES (1, 1, NULL, 5.99, NOW());

COMMIT;


-- ============================================================
-- 8. Transação com ROLLBACK: faz update de um cliente
--    mas desfaz a alteração.
-- ============================================================

START TRANSACTION;

    UPDATE customer
    SET email = 'email_temporario@teste.com'
    WHERE customer_id = 2;

    -- Verificar o estado dentro da transação (alteração visível localmente)
    SELECT customer_id, email FROM customer WHERE customer_id = 2;

ROLLBACK;

-- Após ROLLBACK o email original é restaurado
SELECT customer_id, email FROM customer WHERE customer_id = 2;
