package exercicios;

import java.util.Arrays;

public class TestaEx6 {
    public static void main(String[] args) {
        int[][] matriz = new int[5][5];
        for (int i = 0; i < 5; i++)
            for (int j = 0; j < 5; j++)
                matriz[i][j] = 1;

        ex6 matrix = new ex6(matriz);

        ex6 soma = matrix.soma(matrix);
        ex6 oposta = matrix.matrizOposta();

        System.out.println(matrix.equals(soma));
        System.out.println(Arrays.deepToString(matrix.getMatrix()));
        System.out.println(Arrays.deepToString(soma.getMatrix()));
        System.out.println(Arrays.deepToString(oposta.getMatrix()));
    }
}
