package ex2;

import java.util.Collections;

public class TestaTurmaAlunos {
    public static void main(String[] args) {
        TurmaAlunos t = new TurmaAlunos(Collections.EMPTY_MAP, "LCC Ano 2", "POO");
        System.out.println(t.toString());

        Aluno a = new Aluno("1", 15 ,"Tiago","LCC");
        t.insereAluno(a);
        a = new Aluno("2", 15 ,"Joao","LCC");
        t.insereAluno(a);
        a = new Aluno("3", 15 ,"Pedro","LCC");
        t.insereAluno(a);
        System.out.println(t.toString());

        System.out.println(t.alunosOrdemAlfabetica().toString());
        System.out.println(t.alunosOrdemDecrescenteNumero().toString());
        System.out.println(t.getAluno("1"));
    }
}
