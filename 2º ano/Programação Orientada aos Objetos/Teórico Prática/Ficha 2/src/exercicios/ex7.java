package exercicios;

import java.lang.Math;
import java.util.Scanner;

public class ex7 {
    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);

        int[][] respostas = new int[2][];
        respostas[0] = new int[5];
        respostas[1] = new int[2];

        do {
            System.out.print("Chaves: ");
            for (int i = 0; i < 5; i++) respostas[0][i] = in.nextInt();
        } while(!valido(respostas[0]));

        do {
            System.out.print("Estrelas: ");
            for (int i = 0; i < 2; i++) respostas[1][i] = in.nextInt();
        } while(!validoEstrelas(respostas[1]));

        if (respostaCorreta(respostas, gerador())) {
            for (int i = 0; i < 100; i+=2) {
                for (int espacos = 0; espacos < i; espacos++) System.out.print(" ");
                for (int j = 0; j < 5; j++) System.out.print(respostas[0][j] + " ");
                System.out.print(respostas[1][0] + " ");
                System.out.print(respostas[1][1] + "\n");
            }
        } else System.out.println("Incorreto :(");

    }

    private static boolean respostaCorreta(int[][] respostas, int[][] chaves) {
        boolean correto = true;

        for (int i = 0; i < 5 && correto; i++) {
            if (i < 2) {
                correto = false;
                for (int k = 0; k < 2 && !correto; k++)
                    if (respostas[1][i] == chaves[1][k])
                        correto = true;
            }
            if (correto) {
                correto = false;
                for (int k = 0; k < 5 && !correto; k++)
                    if (respostas[0][i] == chaves[0][k])
                        correto = true;
            }
        }

        return correto;
    }

    private static boolean validoEstrelas(int[] respostas) {
        boolean rep = true;

        for (int i = 0; i < 2 && rep; i++) {
            if (respostas[i] < 0 || respostas[i] > 9) rep = false;
            else {
                for (int j = 0; j < i && rep; j++)
                    if (respostas[i] == respostas[j]) rep = false;
            }
        }

        return rep;
    }

    private static boolean valido(int[] respostas) {
        boolean rep = true;

        for (int i = 0; i < 5 && rep; i++) {
            if (respostas[i] < 0 || respostas[i] > 50) rep = false;
            else {
                for (int j = 0; j < i && rep; j++)
                    if (respostas[i] == respostas[j]) rep = false;
            }
        }

        return rep;
    }
    
    private static int[][] gerador() {
        int[][] chaves = new int[2][];
        chaves[0] = new int[5]; // Numeros
        chaves[1] = new int[2]; // Estrelas

        int[] chavesPossiveis = new int[50];
        for (int i = 0; i < 50; i++) chavesPossiveis[i] = i+1;
        int[] estrelasPossiveis = new int[9];
        for (int i = 0; i < 9; i++) estrelasPossiveis[i] = i+1;

        for (int i = 0; i < 5; i++) {
            int k = (int) (Math.random() * (50-i));
            chaves[0][i] = chavesPossiveis[k];
            swap(chavesPossiveis, k, 50-i-1);
        }
        for (int i = 0; i < 2; i++) {
            int k = (int) (Math.random() * (9-i));
            chaves[1][i] = estrelasPossiveis[k];
            swap(estrelasPossiveis, k, 9-i-1);
        }
        return chaves;
    }

    /* Testes
    private static int[][] gerador() {
        int [][] chaves = new int[2][];
        chaves[0] = new int[]{1, 2, 3, 4, 5};
        chaves[1] = new int[]{1, 2};
        return chaves;
    }
    */

    private static void swap(int[] array, int x, int y) {
        int temp = array[x];
        array[x] = array[y];
        array[y] = temp;
    }
}
