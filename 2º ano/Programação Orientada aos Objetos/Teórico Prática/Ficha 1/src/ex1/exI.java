package ex1;
import static java.lang.Math.abs;
import static java.lang.Math.sqrt;

import java.util.Scanner;
import java.time.LocalDateTime;

public class exI {
    public static void main(String[] args) {
        // Ex 1
        System.out.println(diaDaSemana(30, 3, 2019));

        // Ex 4
        int[] r = mediaTemps(new int[]{15, 12, 20, 23, 18}, 5);
        System.out.print("A media das temperaturas foi de " + r[0] + " graus.\nA maior variaçao registou-se entre os dias " +
                r[1] + " e " + (r[1]+1) + ", tendo a temperatura ");
        if (r[2] > 0) System.out.print("subido ");
        else System.out.print("descido ");
        System.out.println(abs(r[2]) + " graus.");

        // Ex 5
        triangulo();

        // Ex 6
        primos();

        // Ex 7
        idade();
    }

    // Ex 1
    private static String diaDaSemana(int dia, int mes, int ano) {
        int diaSemana = ((ano - 1900)*365) + (ano - 1900)/4;
        if (ano % 4 == 0 && mes < 3) {
            diaSemana--;
        }

        for (int i = 1; i < mes; i++) {
            diaSemana += 30;
            if (i == 1 || i == 3 || i == 5 || i == 7 || i == 8 || i == 10 || i == 12)
                diaSemana++;
            else if (i == 2)
                diaSemana-=2;
        }
        diaSemana += dia;
        return Semana(diaSemana % 7);
    }

    // Ex 2
    private static void somaDatas() {
        // wtf
    }

    // Ex 3
    private static int[] classificacoes(int[] lista, int N) {
        int[] intervalos = {0,0,0,0};
        for (int i = 0; i < N; i++) {
            if (lista[i] >= 0 && lista[i] < 5) intervalos[0]++;
            else if (lista[i] >= 5 && lista[i] < 10) intervalos[1]++;
            else if (lista[i] >= 10 && lista[i] < 15) intervalos[2]++;
            else intervalos[3]++;
        }
        return intervalos;
    }

    // Ex 4
    private static int[] mediaTemps(int[] temperaturas, int N) {
        int[] resultado = {temperaturas[0],0,-1}; // Media, dia, variaçao
        for (int i = 1; i < N; i++) {
            resultado[0] += temperaturas[i];
            int diferenca = temperaturas[i] - temperaturas[i-1];
            if (diferenca > resultado[2]) {
                resultado[1] = i;
                resultado[2] = diferenca;
            }
        }
        resultado[0] /= N;
        return resultado;
    }

    //Ex 5
    private static void triangulo() {
        double base = 1, altura;
        double area, perimetro;
        Scanner input = new Scanner(System.in);
        while (base != 0) {
            System.out.print("Base: ");
            base = input.nextDouble();
            if (base == 0) break;
            System.out.print("Altura: ");
            altura = input.nextDouble();

            area = (base*altura)/2;
            System.out.printf("Area: %.5f\n", area);
        }
    }

    // Ex 6
    private static void primos() {
        Scanner input = new Scanner(System.in);
        int n = input.nextInt();
        for(int i = 2; i < n; i++) {
            if (ePrimo(i)) System.out.printf("%d ", i);
        }
        System.out.println();
        // Ninguem quer "jogar novamente" so... nao vou por isso aqui
    }

    // Ex 7
    private static void idade() { // Tenho a certeza absoluta que ha uma maneira melhor de fazer isto
        Scanner input = new Scanner(System.in);
        System.out.print("Dia: ");
        int dia = input.nextInt();
        System.out.print("Mes: ");
        int mes = input.nextInt();
        System.out.print("Ano: ");
        int ano = input.nextInt();

        int day = LocalDateTime.now().getDayOfMonth();
        int month = LocalDateTime.now().getMonthValue();
        int year = LocalDateTime.now().getYear();
        int hora = LocalDateTime.now().getHour();
        int min = LocalDateTime.now().getMinute();

        int difAno;
        difAno = year - ano;

        int horas;
        horas = (difAno) * 24 * 365 + (year - ano)/4;
        for (int i = mes; i < month; i++) {
            horas += 30*24;
            if (i == 1 || i == 3 || i == 5 || i == 7 || i == 8 || i == 10)
                horas += 24;
            else if (i == 2)
                horas -= 2*24;
        }
        for (int i = dia; i <= day; i++) {
            horas += 24;
        }
        System.out.println("Diferença em horas: " + horas);
        System.out.println("Altura do calculo: " + day + "/" + month + "/" + year + ". Hora: " + hora + ":" + min);
    }

    // Auxiliares
    private static String Semana(int dia) {
        switch(dia) {
            case 0: return "Domingo";
            case 1: return "Segunda-feira";
            case 2: return "Terça-feira";
            case 3: return "Quarta-feira";
            case 4: return "Quinta-feira";
            case 5: return "Sexta-feira";
            case 6: return "Sabado";
        }
        return "Nope";
    }

    private static Boolean ePrimo(int n) {
        boolean primo = true;
        for (int i = 2; i < n; i++)
            if ((n % i) == 0) {
                primo = false;
                break;
            }
        return primo;
    }

}
