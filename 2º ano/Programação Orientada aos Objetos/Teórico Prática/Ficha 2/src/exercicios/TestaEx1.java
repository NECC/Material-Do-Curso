package exercicios;
import java.util.Arrays;
import java.util.Scanner;

public class TestaEx1 {
    public static void main(String[] args) {
        Scanner scan = new Scanner(System.in);
        ex1 teste = new ex1();

        /*
        // Alinea a
        System.out.print("Numero de elementos: ");
        int n = scan.nextInt();
        int[] array = new int[n];
        for (int i = 0; i < n; i++) array[i] = scan.nextInt();

        int min = teste.minimo(array);
        System.out.println("Minimo = " + min);
        // Fim Alinea a

        // Alinea b (com o array anterior)
        int a,b;
        a = scan.nextInt();
        b = scan.nextInt();

        int[] newArray = teste.entreIndices(array, a, b);
        System.out.println(Arrays.toString(newArray));
        // Fim Alinea b
        */

        // Alinea c
        System.out.print("Numero de elementos: ");
        int n = scan.nextInt();
        int[] a = new int[n];
        for (int i = 0; i < n; i++) a[i] = scan.nextInt();

        System.out.print("Numero de elementos: ");
        n = scan.nextInt();
        int[] b = new int[n];
        for (int i = 0; i < n; i++) b[i] = scan.nextInt();

        System.out.println(Arrays.toString(teste.comuns(a, b)));
        // Fim Alinea c



    }
}
