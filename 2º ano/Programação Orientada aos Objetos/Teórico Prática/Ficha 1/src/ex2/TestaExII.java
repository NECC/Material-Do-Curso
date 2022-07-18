package ex2;
import ex2.exII;
import java.util.Scanner;

public class TestaExII {
    private static exII ex;
    private static Scanner scan;

    private static void exercicio1() {
        System.out.print("Celsius: ");
        double celsius = scan.nextDouble();
        System.out.println(ex.celsiusParaFarenheit(celsius));
    }

    private static void exercicio2() {
        System.out.print("a: ");
        int a = scan.nextInt();
        System.out.print("b: ");
        int b = scan.nextInt();
        System.out.println(ex.maximoNumeros(a, b));
    }

    private static void exercicio3() {
        System.out.print("Nome: ");
        String nome = scan.nextLine();
        System.out.print("Saldo: ");
        double saldo = scan.nextDouble();
        System.out.println(ex.criaDescricaoConta(nome, saldo));
    }

    private static void exercicio4() {
        System.out.print("Euros: ");
        double euros = scan.nextDouble();
        System.out.print("Taxa de Conversao: ");
        double taxa = scan.nextDouble();
        System.out.println(ex.eurosParaLibras(euros, taxa));
    }

    private static void exercicio5() {
        System.out.print("a: ");
        int a = scan.nextInt();
        System.out.print("b: ");
        int b = scan.nextInt();
        ex.ordemDecrescente(a,b);
    }

    private static void exercicio6() {
        System.out.print("Numero: ");
        int num = scan.nextInt();
        System.out.println("Factorial de " + num + ": " + ex.factorial(num));
    }

    private static void exercicio7() {
        System.out.println(ex.tempoGasto() + " milisegundos.");
    }

    public static void main(String[] args) {
        ex = new exII();
        scan = new Scanner(System.in);

        //exercicio1();
        //exercicio2();
        //exercicio3();
        //exercicio4();
        //exercicio5();
        //exercicio6();
        exercicio7();

        scan.close();
    }
}
