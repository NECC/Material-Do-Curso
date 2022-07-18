
-- ------------------------------------------------------
-- ------------------------------------------------------
-- Universidade do Minho
-- Mestrado Integrado em Engenharia Informática
-- Lincenciatura em Ciências da Computação
-- Unidade Curricular de Bases de Dados
-- 
-- Caso de Estudo: A Mercearia da D. Acácia
-- Povoamento inicial da base de dados
-- Outubro/2017
-- ------------------------------------------------------
-- ------------------------------------------------------

--
-- Esquema: "Mercearia"
USE `Mercearia` ;

--
-- Permissão para fazer operações de remoção de dados.
SET SQL_SAFE_UPDATES = 0;

--
-- Povoamento da tabela "Cliente"
INSERT INTO Cliente
	(Numero, Nome, DataNascimento, Profissao, Rua, Localidade, CodPostal, Contribuinte, eMail, Compras, RecomendadoPor)
	VALUES 
		(1, 'João da Costa e Campos', 	'1983/12/31',	'Taberneiro', 'Rua das Adegas Felizes, 12, 1ª Cave', 'Aguada do Queixo', 
			'9999-99-99 Queijadas', 	123456789, 'jcc@acacia.pt', 0, NULL),
		(2, 'Josefina Vivida da Paz', 	'1965/10/03',	'Hospedeira', 'Av dos Castros Reais, 122, 3º', 'Friso do Eixo', 
			'7799-77-77 Friso do Eixo', 122133144, 'josefina@acacia.pt', 0, NULL),
		(3, 'Ana Santa do Carmo', 		'1990/08/12',	'Professora', 'Travessa do Jacob, 21', 'Abre o Tacho', 
			'4534-54-21 Vale do Tacho', 876543298, 'saca@acacia.pt', 0, NULL),
		(4, 'Jesualdo Peza-Mor', 		'1978/11/30',	'Carpinteiro', 'Estrada do Sossego, Km10', 'Vale dos Lençóis', 
			'1245-64-11 Camadas', 		564352786, 'pezamor@acacia.pt', 0, NULL),
		(5, 'Maria da Trindade Pascoal','1982/02/05',	'Cozinheira', 'Rua das Adegas da Rua, 15, 10 Esq/T', 'Aguada do Queixo', 
			'9999-99-99 Queijadas', 	777666555, 'trindade@acacia.pt', 0, NULL),
		(6, 'Florindo Teixo Figueirinha','1970/05/22',	'Motorista', 'Autódromo das Vagas, Garagem 123', 'Veloandro', 
			'5555-59-55 Veloandro', 	787676651, 'teixof@acacia.pt', 0, NULL),
		(7, 'Carminho Cunha Bastos', 	'1976/01/13',	'Doméstica', 'Rua do Mus-Vitalis, 56, r/c ', 'Vitalis do Sousa', 
			'6532-A2-43 Vitalis', 		543234111, 'cbastos@acacia.pt', 0, NULL)
	;
--
-- DELETE FROM Cliente;
-- SELECT * FROM Cliente;

--
-- Povoamento da tabela "ClienteTelefones"
INSERT INTO ClienteTelefones
	(Cliente, Telefone)
	VALUES 
		(1,  '678 546 234'),
		(2,  '142 356 429'),
		(3,  '998 765 420'),
		(4,  '675 008 976'),
		(4,  '776 879 332'),
		(5,  '465 423 890'),
		(6,  '866 543 420'),
		(6,  '654 545 218')
	;

--
-- DELETE FROM ClienteTelefones;
-- SELECT * FROM ClienteTelefones;

--
-- Povoamento da tabela "ClienteCupoes"
INSERT INTO ClienteCupoes
	(Cliente, NrCupao, Tipo, Desconto)
	VALUES 
		(1, 1,'Normal'  , 0.10),
		(1, 2,'Superior', 0.20),
		(1, 3,'Extra'   , 0.10),
		(2, 1,'Normal'  , 0.10),
		(4, 1,'Normal'  , 0.10),
		(6, 1,'Normal'  , 0.10),
		(7, 1,'Extra'   , 0.10)
	;
--
-- DELETE FROM ClienteCupoes;
-- SELECT * FROM ClienteCupoes;

--
-- Povoamento da tabela "Dourado"
INSERT INTO Dourado
	(Cliente, Plafond, Desconto)
	VALUES 
		(1, 100.00, 0.10),
		(7,  50.00, 0.15)
	;
--
-- DELETE FROM Dourado;
-- SELECT * FROM Dourado;

--
-- Povoamento da tabela "Produto"
INSERT INTO Produto
	(Numero, Designacao, Unidade, Preco, Tipo)
	VALUES 
		(1,  'Arroz Belo Campo', 		'Un', 1.00, 'Cereais'),
		(2,  'Leite Pasto Sagrado', 	'Lt', 0.60, 'Lacticínios'),
		(3,  'Yogurt Ar do Brejo', 		'Un', 0.25, 'Lacticínios'),
		(4,  'Massa Pão de Anjo', 		'Kg', 0.75, 'Massas'),
		(5,  'Azeite da Magnífica', 	'Lt', 3.70, 'Óleos'),
		(6,  'Pão de Centeio do Prado',	'Un', 0.15, 'Padaria'),
		(7,  'Água Rochas Doces', 		'Lt', 0.50, 'Águas'),
		(8,  'Mortadela da Luz', 		'Kg', 4.20, 'Charcutaria'),
		(9,  'Bife Corte Real Embalado','Kg', 8.50, 'Carne'),
		(10, 'Pescada do Ártico', 		'Kg', 4.30, 'Peixe'),
		(11, 'Salmão Fumado Rio ALto', 	'Kg', 6.45, 'Peixe'),
		(12, 'Chocolate Cacau Real',	'Un', 1.75, 'Doces')
	;
--
-- DELETE FROM Produto;
-- SELECT * FROM Produto;

--
-- Povoamento da tabela "Venda"
INSERT INTO Venda
	(Numero, Data, Estado, Total, Cliente)
	VALUES 
		(1,  '2017/10/05', 'S',  61.00, 1),
		(2,  '2017/10/05', 'S',  44.40, 2),
		(3,  '2017/10/07', 'S',  52.50, 3),
		(4,  '2017/10/08', 'S',  38.70, 1),
		(5,  '2017/10/08', 'N',  52.00, 5)
	;
--
-- DELETE FROM Venda;
-- SELECT * FROM Venda;

--
-- Povoamento da tabela "VendaProduto"
INSERT INTO VendaProduto
	(Venda, Produto, Quantidade, Preco, Valor)
	VALUES 
		(1, 1, 10.00, 1.00, 10.00),
		(1, 2, 10.00, 0.60,  6.00),
		(1, 9,  5.00, 8.50, 42.50),
		(1, 7,  5.00, 0.50,  2.50),
		(2, 5, 12.00, 3.70, 44.40),
		(3, 1, 10.00, 1.00, 10.00),
		(3, 9,  5.00, 8.50, 42.50),
		(4, 11, 6.00, 6.45, 38.70),
		(5, 4, 20.00, 0.75, 15.00),
		(5, 5, 10.00, 3.70, 37.00)
	;
--
-- DELETE FROM VendaProduto;
-- SELECT * FROM VendaProduto;


-- ------------------------------------------------------
-- <fim>
-- Belo, O. 2017
-- ------------------------------------------------------
