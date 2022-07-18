package exercicios;

public class ex2 {
    private int[][] notasTurma;

    public ex2() {
        this.notasTurma = new int[5][5];
    }

    public void atualizaPauta(int[][] notas) {
        for (int i = 0; i < 5; i++) {
            System.arraycopy(notas[i],0,this.notasTurma[i],0,5);
        }
    }

    public int somaNotasUC(int uc) {
        int soma = 0;
        for (int i = 0; i < 5; i++) soma += this.notasTurma[i][uc];
        return soma;
    }

    public int[][] getPauta() {
        int[][] res = new int[5][5];
        for (int i = 0; i < 5; i++) {
            System.arraycopy(this.notasTurma[i],0,res[i],0,5);
        }
        return res;
    }

    public double mediaAluno(int aluno) {
        int soma = 0;

        for (int i = 0; i < 5; i++)
            soma += this.notasTurma[aluno][i];

        return soma/5.0;
    }

    public double mediaUC(int uc) {
        int soma = 0;

        for (int i = 0; i < 5; i++)
            soma += this.notasTurma[i][uc];

        return soma/5.0;
    }

    public int notaMaisAlta() {
        int maisAlta = Integer.MIN_VALUE;

        for (int[] aluno: this.notasTurma)
            for (int nota: aluno)
                if (nota > maisAlta) maisAlta = nota;

        return maisAlta;
    }

    public int notaMaisBaixa() {
        int maisBaixa = Integer.MAX_VALUE;

        for (int[] aluno: this.notasTurma)
            for (int nota: aluno)
                if (nota < maisBaixa) maisBaixa = nota;

        return maisBaixa;
    }

    public int[] notasAcimaDeX(int x) {
        int[] notas = new int[25];
        int i = 0;

        for (int[] aluno: this.notasTurma)
            for (int nota: aluno)
                if (nota > x) notas[i++] = nota;

        int[] resultado = new int[i];
        System.arraycopy(notas,0,resultado,0,i);

        return resultado;
    }

    public String notas() {
        String notas = "Notas dos Alunos: \n";

        for (int i = 0; i < 5; i++) {
            notas = notas.concat("Aluno " + i + ":\n");
            for (int j = 0; j < 5; j++) {
                notas = notas.concat("UC " + j + ": " + this.notasTurma[i][j] + "\n");
            }
        }

        return notas;
    }

    public int mediaMaisAlta() {
        double media, mediaMaisAlta = this.mediaUC(0);
        int maisAlta = 0;

        for (int i = 1; i < 5; i++) {
            media = this.mediaUC(i);
            if (media > mediaMaisAlta) {
                maisAlta = i;
                mediaMaisAlta = media;
            }
        }

        return maisAlta;
    }
}
