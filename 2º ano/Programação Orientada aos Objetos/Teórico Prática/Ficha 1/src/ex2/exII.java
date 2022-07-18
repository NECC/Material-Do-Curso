package ex2;

public class exII {
    // Ex 1 -> Converter Celsius para Farenheit
    public double celsiusParaFarenheit(double graus) {
        return graus*1.8+32;
    }
    // Ex 2 -> Maximo de 2 numeros inteiros
    public int maximoNumeros(int a, int b) {
        return Math.max(a, b);
    }
    // Ex 3
    public String criaDescricaoConta(String nome, double saldo) {
        return "Nome: " + nome + ". Saldo: " + saldo;
    }
    // Ex 4
    public double eurosParaLibras(double valor, double taxaDeConversao) {
        return valor*taxaDeConversao;
    }
    // Ex 5
    public void ordemDecrescente(int a, int b) {
        System.out.println("Numero menor: " + Math.min(a,b) +
                "\nNumero maior: " + Math.max(a,b) +
                "\nMedia: " + (a+b)/2.0);
    }
    // Ex 6
    public long factorial(int num) {
        long fact = 1;
        for(int i = 1; i <= num; i++)
            fact *= i;
        return fact;
    }
    // Ex 7
    public long tempoGasto() {
        long antes = System.currentTimeMillis();
        this.factorial(100000000);
        long depois = System.currentTimeMillis();
        return depois-antes;
    }
}
