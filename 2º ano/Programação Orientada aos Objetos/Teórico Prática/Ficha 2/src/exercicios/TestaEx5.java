package exercicios;
import java.util.Arrays;
import java.util.Scanner;

public class TestaEx5 {
    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        ex5 classe = new ex5(10);


        classe.adicionaString("Ola");
        classe.adicionaString("Tiago");
        classe.adicionaString("Grand Theft Auto V");
        classe.adicionaString("Ola");
        classe.adicionaString("Carriço");
        classe.adicionaString("Grand Theft Auto V");
        classe.adicionaString("Grand Theft Auto V");
        classe.adicionaString("Bola");

        alineaA(in, classe);
        alineaB(in, classe);
        alineaC(in, classe);
        alineaD(in, classe);

    }

    private static void alineaA(Scanner in, ex5 classe) {
        System.out.println(Arrays.toString(classe.stringsExistentes()));
    }

    private static void alineaB(Scanner in, ex5 classe) {
        System.out.println(classe.maiorString());
    }

    private static void alineaC(Scanner in, ex5 classe) {
        System.out.println(Arrays.toString(classe.repetidos()));
    }

    private static void alineaD(Scanner in, ex5 classe) {
        System.out.println(classe.ocorrencias("Grand Theft Auto V"));
    }
}
