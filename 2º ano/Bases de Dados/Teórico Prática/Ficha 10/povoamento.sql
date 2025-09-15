USE universidade;

-- inserção de departamentos
INSERT INTO Departamento 
	(idDepartamento, designacao) 
    VALUES 
		(1, "Matemática"),
        (2, "Engenharia Informática"),
        (3, "Engenharia Mecânica"),
        (4, "Química"),
        (5, "Física"),
        (6, "Economia");

-- inserção de categorias de docentes
-- DELETE FROM Categoria WHERE idCategoria IN (1,2,3,4,5,6);

INSERT INTO Categoria
	(idCategoria, designacao)
    VALUES
		(1, "Catedrático"),
        (2, "Associado com Agregação"),
        (3, "Associado e Auxiliar com Agregação"),
        (4, "Auxiliar"),
        (5, "Assistente"),
        (6, "Estagiário");


-- inserção de docentes
INSERT INTO Docente
	(idDocente, nome, idCategoria) 
    VALUES
		(1001, "JBB", 2),
        (1002, "JSP", 3),
        (1003, "VALENÇA", 1),
        (1004, "Antonienta", 4),
        (1005, "António", 6),
        (1006, "Cristina", 2);


-- inserção de disciplinas
INSERT INTO Disciplina
	(idDisciplina, designacao, idDocente, idDepartamento)
	VALUES
		(2001, "Programação Funcional", 1001, 2),
        (2002, "Algoritmos e Complexidade", 1002, 2),
        (2003, "Lógica Computacional", 1003, 2),
        (2004, "Eletrónica", 1004, 3),
        (2005, "Contabilidade", 1005, 6),
        (2006, "Geometria", 1006, 1);
        

-- inserção de cursos
INSERT INTO Curso
	(idCurso, designacao)
	VALUES
		(3001, "Ciências da Computação"),
        (3002, "Engenharia Informática"),
        (3003, "Contabilidade"),
        (3004, "Engenharia Eletrónica"),
        (3005, "Gestão"),
        (3006, "Engenharia Física");

        
-- inserção de relações de muitos para muitos de disciplinas e cursos
INSERT INTO Disciplina_Curso
	(idDisciplina, idCurso)
    VALUES
		(2001, 3001),
        (2001, 3002),
        (2001, 3006),
        (2005, 3003),
        (2006, 3001),
        (2004, 3004);
        
-- inserção de anos letivos
INSERT INTO AnoLetivo
	(idAnoLetivo, texto)
    VALUES
		(1, "2014/2015"),
        (2, "2015/2016"),
        (3, "2016/2017"),
        (4, "2018/2019"),
        (5, "2019/2020"),
        (6, "2020/2021");


-- inserção de Exames
INSERT INTO Exame
	(idExame, idDisciplina, dataCriacao, nivelDificuldade)
    VALUES
		(10, 2001, DATE("2014-03-12"), 5.2),
        (11, 2001, DATE("2015-02-11"), 3.1),
        (12, 2004, DATE("2016-06-23"), 1.0),
        (13, 2004, DATE("2017-04-23"), 7.4),
        (14, 2002, DATE("2020-11-12"), 4.2),
        (15, 2002, DATE("2019-12-11"), 9.2);
        
-- inserção de Questoes
INSERT INTO Questao
	(idQuestoes, texto, nivelDificuldade)
    VALUES
		(1, "Quantos anos terias se não soubesses quantos anos tens?", 4),
        (2, "O que é pior, falhar ou nunca tentar?", 3),
        (3, "Quando tudo já está dito e feito, será que disseste mais do que fizeste?", 6),
        (4, "Se a felicidade fosse a moeda nacional, que tipo de trabalho te tornaria rico?", 7),
        (5, "Até que ponto controlaste o curso da tua vida?", 8),
        (6, "Se pudesses mudar para um lugar desconhecido, para onde iria e porque?", 5);

-- inserção de relações entre exame e questoes
INSERT INTO Exame_Questao
	(idExame, idQuestoes, ordem, pontuacao)
    VALUES
		(10, 1, 1, 10.0),
        (10, 2, 2, 10.0),
        (11, 3, 2, 5.0),
        (11, 4, 1, 5.0),
        (12, 5, 2, 10.0),
        (12, 6, 1, 10.0);
        
-- inserção de relações de Disciplinas com Exames e com ano
INSERT INTO Disciplina_Exame_Ano
	(id_Disciplina, id_Exame, id_Ano, data_Exame, tipo_Exame)
    VALUES
		(2001, 10, 1, DATE("2014-03-15"), "Escolhas múltiplas"),
        (2001, 11, 2, DATE("2015-02-11"), "Resposta rápida"),
        (2002, 12, 3, DATE("2016-06-25"), "Desenvolvimento"),
        (2002, 13, 3, DATE("2017-04-26"), "Escolhas múltiplas"),
        (2005, 14, 4, DATE("2020-11-17"), "Escolhas múltiplas"),
        (2006, 15, 5, DATE("2019-12-15"), "Desenvolvimento");
        
        