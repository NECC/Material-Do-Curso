package exercicios;

import java.util.Scanner;

public class testes {
    /** */
    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);

        //ex1(in);

        ex5(in);
    }

    /** */
    private static void ex1(Scanner in) {
        Circulo c1 = new Circulo();
        System.out.println(c1.toString());

        Circulo c2 = new Circulo();
        System.out.println(c1.equals(c2));

        System.out.print("Input: \nx: ");
        double x = in.nextDouble();
        System.out.print("y: ");
        double y = in.nextDouble();
        System.out.print("Raio: ");
        double raio = in.nextDouble();
        c2.alteraCentro(x,y);
        c2.setRaio(raio);

        System.out.println(c1.equals(c2));

        System.out.println(c2.calculaArea());
        System.out.println(c2.calculaPerimetro());
    }

    private static void ex5(Scanner in) {
        jogo j = new jogo("Benfica", "Porto");

        j.startGame();
        System.out.println(j.resultadoAtual());

        j.goloVisitado();
        System.out.println(j.resultadoAtual());

        j.goloVisitado();
        System.out.println(j.resultadoAtual());

        j.goloVisitante();
        System.out.println(j.resultadoAtual());
        j.endGame();
        System.out.println(j.toString());
    }
}
