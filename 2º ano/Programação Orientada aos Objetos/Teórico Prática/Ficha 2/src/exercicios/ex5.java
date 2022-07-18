package exercicios;

public class ex5 {
    private String[] array;
    private int tamanho;
    private int ocupacao;

    public ex5(int tam) {
        this.array = new String[tam];
        this.tamanho = tam;
    }

    public boolean adicionaString(String a) {
        if (this.ocupacao == this.tamanho) return false;
        this.array[ocupacao++] = new String(a);
        return true;
    }

    public String[] stringsExistentes() {
        String[] array = new String[this.ocupacao];
        int i=0;
        for (int k = 0; k < this.ocupacao; k++) {
            boolean rep = false;
            for (int j = 0; j < i; j++)
                if (array[j].equals(this.array[k])) {
                    rep = true;
                    break;
                }
            if (!rep) array[i++] = new String(this.array[k]);
        }

        String[] res = new String[i];
        System.arraycopy(array,0,res,0,i);
        return res;
    }

    public String maiorString() {
        int maiorLe = -1;
        String maior = null;

        for (int i = 0; i < this.ocupacao; i++) {
            String elem = this.array[i];
            if (elem.length() > maiorLe) {
                maiorLe = elem.length();
                maior = elem;
            }
        }

        return new String(maior);
    }

    public String[] repetidos() {
        String[] array = new String[this.ocupacao];
        int p = 0;
        for (int i = 0; i < this.ocupacao; i++) {
            if (this.repete(this.array[i]) && !this.repeteAte(this.array[i], array, p)) {
                array[p++] = this.array[i];
            }
        }
        String[] res = new String[p];
        System.arraycopy(array,0,res,0,p);
        return res;

    }

    public int ocorrencias(String a) {
        int oc = 0;
        for (int i = 0; i < this.ocupacao; i++) {
            if (this.array[i].equals(a)) oc++;
        }
        return oc;
    }

    private boolean repete(String a) {
        return this.ocorrencias(a) > 1;
    }

    private boolean repeteAte(String a, String[] array, int n) {
        int oc = 0;
        for (int i = 0; i < n && oc <= 1; i++) {
            if (a.equals(array[i])) oc++;
        }
        return oc > 0;
    }

}
