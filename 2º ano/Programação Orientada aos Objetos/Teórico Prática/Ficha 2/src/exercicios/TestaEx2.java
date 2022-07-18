package exercicios;
import java.util.Arrays;
import java.util.Scanner;

public class TestaEx2 {
    public static void main(String[] args) {
        ex2 turma = new ex2();
        int[][] pauta = new int[5][5];
        Scanner in = new Scanner(System.in);

        for (int i = 0; i < 5; i++) {
            for (int j = 0; j < 5; j++){
                System.out.print("Aluno: " + i + ", UC: " + j + " => ");
                pauta[i][j] = in.nextInt();
            }
        }
        turma.atualizaPauta(pauta);
        System.out.println(Arrays.deepToString(turma.getPauta()));

        //alineaB(turma, in);
        //alineaC(turma, in);
        //alineaD(turma, in);
        //alineaE(turma);
        //alineaF(turma);
        //alineaG(turma, in);
        //alineaH(turma);
        alineaI(turma);

    }

    private static void alineaB(ex2 turma, Scanner in) {
        int uc;
        do {
            System.out.print("Unidade Curricular (0-4): ");
            uc = in.nextInt();
        } while (!(uc >= 0 && uc <= 4));

        int soma = turma.somaNotasUC(uc);
        System.out.println("Soma das notas da UC " + uc + ": " + soma);

    }

    private static void alineaC(ex2 turma, Scanner in) {
        int aluno;
        do {
            System.out.print("Aluno (0-4): ");
            aluno = in.nextInt();
        } while(!(aluno >= 0 && aluno < 5));

        System.out.println(turma.mediaAluno(aluno));
    }

    private static void alineaD(ex2 turma, Scanner in) {
        int uc;
        do {
            System.out.print("Aluno (0-4): ");
            uc = in.nextInt();
        } while(!(uc >= 0 && uc < 5));

        System.out.println(turma.mediaUC(uc));
    }

    private static void alineaE(ex2 turma) {
        System.out.println("Nota mais alta: " + turma.notaMaisAlta());
    }

    private static void alineaF(ex2 turma) {
        System.out.println("Nota mais baixa: " + turma.notaMaisBaixa());
    }

    private static void alineaG(ex2 turma, Scanner in) {
        int x;
        System.out.print("Valor: ");
        x = in.nextInt();

        System.out.println(Arrays.toString(turma.notasAcimaDeX(x)));
    }

    private static void alineaH(ex2 turma) {
        System.out.println(turma.notas());
    }

    private static void alineaI(ex2 turma) {
        System.out.println(turma.mediaMaisAlta());
    }
}
