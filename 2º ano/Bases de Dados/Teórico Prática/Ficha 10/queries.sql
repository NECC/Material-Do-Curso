USE universidade;

-- Quais são os nomes dos professores que são responsáveis pelas diversas disciplinas do
-- departamento?
DELIMITER %%
CREATE PROCEDURE listarProfessoresPorDepartamento(IN id INT)
	BEGIN
		SELECT prof.nome FROM Disciplina AS D
        INNER JOIN Docente AS prof
        ON D.idDocente = prof.idDocente
        INNER JOIN Departamento AS Depart
        ON Depart.idDepartamento = D.idDepartamento
        WHERE Depart.idDepartamento = id;
    END
%%

CALL listarProfessoresPorDepartamento(2);