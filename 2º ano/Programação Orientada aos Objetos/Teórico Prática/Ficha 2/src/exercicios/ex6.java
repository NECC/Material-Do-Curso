package exercicios;

import java.util.Scanner;

public class ex6 {
    private int[][] matrix;
    private int N;
    private int M;

    public ex6(int[][] input) {
        this.N = input.length;
        this.M = input[0].length;
        matrix = new int[this.N][this.M];
        for (int i = 0; i < this.N; i++)
            System.arraycopy(input[i],0,this.matrix[i],0,M);
    }

    public ex6 soma(ex6 second) {
        if (this.N == second.N && this.M == second.M) {
            ex6 soma = new ex6(this.matrix);
            for (int i = 0; i < this.N; i++) {
                for (int j = 0; j < this.M; j++) {
                    soma.matrix[i][j] += second.matrix[i][j];
                }
            }
            return soma;
        } else return null;
    }

    public boolean equals(ex6 second) {
        if (this.N == second.N && this.M == second.M) {
            boolean rep = true;

            for (int i = 0; i < this.N && rep; i++)
                for (int j = 0; j < this.M && rep; j++)
                    rep = this.matrix[i][j] == second.matrix[i][j];

            return rep;
        } else return false;
    }

    public ex6 matrizOposta() {
        int[][] oposta = new int[this.N][this.M];

        for (int i = 0; i < this.N; i++)
            for (int j = 0; j < this.M; j++)
                oposta[i][j] = -this.matrix[i][j];

        return new ex6(oposta);
    }

    public int[][] getMatrix() {
        return this.matrix;
    }
}
