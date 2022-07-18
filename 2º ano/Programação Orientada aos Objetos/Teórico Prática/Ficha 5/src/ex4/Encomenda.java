package ex4;

import java.time.LocalDate;
import java.util.ArrayList;

/**
 * Feito por:
 * Joao Manuel Novais da Silva - A91671
 * Francisco Pereira Teofilo - A93741
 * Pedro António Pires Correia Leite Sequeira - A91660
 * Tiago dos Santos Silva Peixoto Carriço - A91695
 */

public class Encomenda {
    //Variaveis de instancia
    private String nome;
    private String NIF;
    private String morada;
    private String numero;
    private LocalDate data;
    private ArrayList<LinhaEncomenda> encomendas;

    //Construtores
    public Encomenda(String nomeCliente, String nif, String moradaCliente, String numeroEncomenda,
                     LocalDate dataEncomenda, ArrayList<LinhaEncomenda> lista) {
        this.nome = nomeCliente;
        this.NIF = nif;
        this.morada = moradaCliente;
        this.numero = numeroEncomenda;
        this.data = dataEncomenda;
        this.encomendas = new ArrayList<LinhaEncomenda>(lista);
    }
    public Encomenda() {
        this("","","","",LocalDate.now(),new ArrayList<LinhaEncomenda>());
    }
    public Encomenda(Encomenda enc) {
        this(enc.nome, enc.NIF, enc.morada, enc.numero, enc.data, enc.encomendas);
    }

    //Metodos de instancia
    public Encomenda clone() {
        return new Encomenda(this);
    }
    public boolean equals(Object p) {
        if (p == this) return true;

        if (p == null || this.getClass() != p.getClass()) return false;

        Encomenda enc = (Encomenda) p;
        return this.nome.equals(enc.nome) && this.NIF.equals(enc.NIF) &&
                this.morada.equals(enc.morada) && this.numero.equals(enc.numero) &&
                this.data.equals(enc.data) && this.encomendas.equals(enc.encomendas);
    }
    public String toString() {
        StringBuffer sb = new StringBuffer();

        sb.append("Nome:"); sb.append(this.nome);
        sb.append("\nNIF: "); sb.append(this.NIF);
        sb.append("\nMorada: "); sb.append(this.morada);
        sb.append("\nNumero de encomenda: "); sb.append(this.numero);
        sb.append("\nData: "); sb.append(this.data.toString());
        sb.append("\nLista de encomendas: "); sb.append(this.encomendas.toString());

        return sb.toString();
    }
    public double calculaValorTotal() {
        return this.encomendas.stream().mapToDouble(LinhaEncomenda::calculaValorLinhaEnc).sum();
    }
    public double calculaValorDesconto() {
        return this.encomendas.stream().mapToDouble(LinhaEncomenda::calculaValorDesconto).sum();
    }
    public int numeroTotalProdutos() {
        return this.encomendas.stream().mapToInt(LinhaEncomenda::getQuantidade).sum();
    }
    public boolean existeProdutoEncomenda(String refProduto) {
        return this.encomendas.stream().anyMatch(enc->enc.getReferencia().equals(refProduto));
    }
    public void adicionaLinha(LinhaEncomenda linha) {
        this.encomendas.add(linha.clone());
    }
    public void removeProduto(String codProduto) {
        this.encomendas.removeIf(enc->enc.getReferencia().equals(codProduto));
    }

    //setters e getters
    public void setNome(String n) {
        this.nome = n;
    }
    public void setNIF(String nif) {
        this.NIF = nif;
    }
    public void setNumero(String numero) {
        this.numero = numero;
    }
    public void setData(LocalDate date) {
        this.data = date;
    }
    public void setEncomendas(ArrayList<LinhaEncomenda> lista) {
        this.encomendas = new ArrayList<LinhaEncomenda>();
        for (LinhaEncomenda linha : lista)
            this.encomendas.add(linha.clone());
    }
    public void setMorada(String morada) {
        this.morada = new String(morada);
    }
    public String getNome() {
        return this.nome;
    }
    public String getMorada() {
        return this.morada;
    }
    public String getNumero() {
        return this.numero;
    }
    public String getNIF() {
        return this.NIF;
    }
    public LocalDate getData() {
        return this.data;
    }
    public ArrayList<LinhaEncomenda> getEncomendas() {
        ArrayList<LinhaEncomenda> ret = new ArrayList<LinhaEncomenda>();
        for (LinhaEncomenda linha : this.encomendas)
            ret.add(linha.clone());
        return ret;
    }
}
