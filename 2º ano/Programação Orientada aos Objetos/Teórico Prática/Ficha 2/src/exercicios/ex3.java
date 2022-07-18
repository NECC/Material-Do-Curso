package exercicios;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;


public class ex3 {
    private LocalDate[] datas;
    private int tamanho;
    private int ocupacao = 0;

    public ex3(int tamanho) {
        this.datas = new LocalDate[tamanho];
        this.tamanho = tamanho;
    }

    public void insereData(LocalDate data) {
        this.datas[ocupacao++] = data;
    }

    public LocalDate dataMaisProxima(LocalDate data) {
        long dist = Integer.MAX_VALUE, d;
        LocalDate maisProxima = null;

        for (int i = 0; i < ocupacao; i++) {
            d = Math.abs(ChronoUnit.DAYS.between(this.datas[i],data));
            System.out.println(d);
            if (d < dist) {
                dist = d;
                maisProxima = this.datas[i];
            }
        }

        return maisProxima;
    }

    public String toString() {
        String datas = "Datas:\n";
        LocalDate data;
        for (int i = 0; i < this.ocupacao; i++) {
            data = this.datas[i];
            datas = datas.concat(String.valueOf(data));
            datas = datas.concat("\n");
        }
        return datas;
    }
}
