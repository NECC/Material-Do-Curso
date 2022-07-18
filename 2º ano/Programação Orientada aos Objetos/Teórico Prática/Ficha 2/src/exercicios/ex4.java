package exercicios;

import java.util.Arrays;
import java.util.Scanner;

public class ex4 {
    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        System.out.print("Tamanho: ");
        int n = in.nextInt();
        int[] array = new int[n];

        for (int i = 0; i < n; i++) array[i] = in.nextInt();

        ordena(array);
        System.out.println(Arrays.toString(array));

        System.out.print("Binary Search: ");
        int x = in.nextInt();
        System.out.println(binarySearch(array, x, array.length-1));
    }

    // Alinea a
    // Insertion sort
    private static void ordena(int[] array) {
        int menor;

        for (int i = 0; i < array.length; i++) {
            menor = i;
            for (int j = i; j < array.length; j++)
                if (array[j] < array[menor]) menor = j;
            swap(array, i, menor);
        }
    }

    // Alinea b
    private static int binarySearch(int[] array, int x, int max) {
        int i = -1;
        int min = 0;
        int mid = max/2;
        while (min < max) {
            if (array[mid] == x) {
                i = mid;
                break;
            } else {
                if (array[mid] < x) {
                    min = mid+1;
                } else {
                    max = mid-1;
                }
                mid = (min + max)/2;
            }
        }
        if (min == max && array[min] == x) i = min;
        return i;
    }

    private static void swap(int[] array, int x, int y) {
        int temp = array[x];
        array[x] = array[y];
        array[y] = temp;
    }
}
