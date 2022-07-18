package exercicios;

import java.time.LocalDate;
import java.util.Scanner;

public class TestaEx3 {
    public static void main(String[] args) {
        ex3 datas = new ex3(10);
        Scanner in = new Scanner(System.in);

        adicionarData(in, datas);
        adicionarData(in, datas);
        adicionarData(in, datas);

        LocalDate data;
        System.out.print("Dia: ");
        int dia = in.nextInt();//1-31
        System.out.print("Mes: ");
        int mes = in.nextInt(); //1-12
        System.out.print("Ano: ");
        int ano = in.nextInt();
        data = LocalDate.of(ano, mes, dia);

        System.out.println("Data mais proxima: " + datas.dataMaisProxima(data));

        System.out.println(datas.toString());

    }

    private static void adicionarData(Scanner in, ex3 datas) {
        System.out.print("Dia: ");
        int dia = in.nextInt();//1-31
        System.out.print("Mes: ");
        int mes = in.nextInt(); //1-12
        System.out.print("Ano: ");
        int ano = in.nextInt();

        LocalDate data = LocalDate.of(ano, mes, dia);

        datas.insereData(data);
    }
}
