package exercicios;

public class ex1 {
    public int minimo(int[] array) {
        int min = Integer.MAX_VALUE;
        for(int elem: array) {
            if (elem < min) min = elem;
        }
        return min;
    }

    public int[] entreIndices(int[] array, int a, int b) {
        if (a > b || a < 0 || b > array.length) {
            return null;
        }
        int[] resultado = new int[b-a+1];
        System.arraycopy(array, a, resultado, 0, b - a + 1);
        return resultado;
    }

    public int[] comuns(int[] a, int[] b) {
        int[] res = new int[a.length];
        int count = 0;

        for (int elem: a) {
            boolean enc = this.existe(res, count, elem);
            for (int i = 0; i < b.length && !enc; i++) {
                if (enc = (elem == b[i])) {
                    res[count++] = elem;
                }
            }
        }
        int[] resultadoFinal = new int[count];
        System.arraycopy(res,0,resultadoFinal,0,count);

        return resultadoFinal;
    }

    private boolean existe(int[] array, int n, int elem) {
        boolean res = false;

        for(int i = 0; i < n && !res; i++) res = array[i] == elem;

        return res;
    }
}
