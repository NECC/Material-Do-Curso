package exercicios;

import java.time.LocalDate;

public class Encomenda {
    private String nome;
    private int NIF;
    private String morada;
    private int numero;
    private LocalDate data;
    private LinhaEncomenda[] encomendas;

    public Encomenda(String name, int nif, String mo, int num) {
        this.setNome(name);
        this.setNIF(nif);
        this.setMorada(mo);
        this.setNumero(num);
        LinhaEncomenda[] e = new LinhaEncomenda[0];
        this.setEncomendas(e);
    }

    public Encomenda() {
        this("Nao determinada", 1, "Nao determinada", 1);
    }

    public Encomenda(Encomenda e) {
        this(e.getNome(), e.getNIF(), e.getMorada(), e.getNumero());
    }

    public double calculaValorTotal() {
        LinhaEncomenda[] array = this.getEncomendas();
        double soma = 0;
        for (LinhaEncomenda linhaEncomenda : array) soma += linhaEncomenda.calculaValorLinhaEncomenda();
        return soma;
    }

    public double calculaValorDesconto() {
        LinhaEncomenda[] array = this.getEncomendas();
        double soma = 0;
        for (LinhaEncomenda linhaEncomenda : array) soma += linhaEncomenda.calculaValorDesconto();
        return soma;
    }

    public int numeroTotalProdutos() {
        LinhaEncomenda[] array = this.getEncomendas();
        int soma = 0;
        for (LinhaEncomenda linhaEncomenda : array) soma += linhaEncomenda.getQuantidade();
        return soma;
    }

    public boolean existeProdutoEncomenda(String refProduto) {
        LinhaEncomenda[] array = this.getEncomendas();
        boolean enc = false;
        for (int i = 0; i < array.length && !enc; i++) enc = array[i].getReferencia().equals(refProduto);
        return enc;
    }

    public void adicionaLinha(LinhaEncomenda linha) {
        LinhaEncomenda[] array = this.getEncomendas();
        LinhaEncomenda[] novo = new LinhaEncomenda[array.length+1];
        System.arraycopy(array, 0, novo, 0, array.length);
        novo[array.length] = new LinhaEncomenda(linha);
        this.setEncomendas(novo);
    }

    public void removeProduto(String codPro) {
        LinhaEncomenda[] array = this.getEncomendas();
        LinhaEncomenda[] novo = new LinhaEncomenda[array.length+1];
        int ind = -1;
        for (int i = 0; i < array.length && ind == -1; i++) {
            if (array[i].getReferencia().equals(codPro)) {
                ind = i;
            }
        }
        System.arraycopy(array, 0, novo, 0, ind);
        System.arraycopy(array, ind+1, novo, ind, array.length-ind);
        this.setEncomendas(novo);
    }

    // sets e gets
    public String getNome() {
        return this.nome;
    }
    public int getNIF() {
        return this.NIF;
    }
    public String getMorada() {
        return this.morada;
    }
    public int getNumero() {
        return this.numero;
    }
    public LocalDate getData() {
        return this.data;
    }
    public LinhaEncomenda[] getEncomendas() {
        LinhaEncomenda[] array = new LinhaEncomenda[this.encomendas.length];
        for (int i = 0; i < this.encomendas.length; i++) array[i] = new LinhaEncomenda(this.encomendas[i]);
        return array;
    }

    public void setNome(String name) {
        this.nome = new String(name);
    }
    public void setNIF(int nif) {
        this.NIF = nif;
    }
    public void setMorada(String mo) {
        this.morada = new String(mo);
    }
    public void setNumero(int num) {
        this.numero = num;
    }
    public void setData(LocalDate date) {
        this.data = date;
    }
    public void setEncomendas(LinhaEncomenda[] e) {
        this.encomendas = new LinhaEncomenda[e.length];
        for (int i = 0; i < e.length; i++) this.encomendas[i] = new LinhaEncomenda(e[i]);
    }

}
