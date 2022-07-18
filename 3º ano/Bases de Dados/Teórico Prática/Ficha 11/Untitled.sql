USE Mercearia;

DROP PROCEDURE IF EXISTS cupoes;

DELIMITER $$
CREATE PROCEDURE cupoes()
	BEGIN
		-- são as duas chaves da do clientCupoes
		DECLARE p_cliente INT; 
        DECLARE p_cupao INT;
        DECLARE fim INT DEFAULT 0;
        
        DECLARE vendas300 CURSOR FOR 
        SELECT cliente FROM Venda
        WHERE total >= 300 and data >= ADDDATE(sysdate(), INTERVAL -4 week); 
        
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET fim = 1;
        
        OPEN vendas300;
        REPEAT
			FETCH vendas300 INTO p_cliente;
            IF NOT fim THEN
				SELECT IFNULL(MAX(nrcupao),0)+1 into p_cupao FROM ClienteCupoes
                WHERE cliente=p_cliente;
                INSERT INTO ClienteCupoes (Cliente, nrcupao,tipo,desconto)
                VALUES (p_cliente, p_cupao, "especial", 0.15);
            END IF;
        UNTIL fim
        END REPEAT;
        
	END 

$$

CALL cupoes();

SELECT * FROM ClienteCupoes;
SELECT * FROM Venda;

-- TENHO DE INSERIR UMA VENDA



-- segunda pergunta

DELIMITER $$
CREATE PROCEDURE sp_InsereVenda()
	BEGIN
		DECLARE Erro BOOL DEFAULT 0;
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET Erro = 1;
		
        -- definição do inicio da transação
        START TRANSACTION;
        INSERT INTO Venda () VALUES ();
        INSERT INTO VendaProduto () VALUES ();
        INSERT INTO VendaProduto () VALUES ();
        
        UPDATE Cliente set Compras = .. WHERE ;
			IF Erro THEN
				ROLLBACK;
			ELSE:
				COMMIT;
	END
$$