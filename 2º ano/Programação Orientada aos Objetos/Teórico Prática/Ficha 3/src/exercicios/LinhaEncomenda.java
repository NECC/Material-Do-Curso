package exercicios;

public class LinhaEncomenda {
    private String referencia;
    private String descricao;
    private double preco;
    private int quantidade;
    private double imposto;
    private double descontoComercial;

    public LinhaEncomenda(String ref, String desc, double pr, int quant, double imp, double desconto) {
        this.setReferencia(ref);
        this.setDescricao(desc);
        this.setDescontoComercial(desconto);
        this.setImposto(imp);
        this.setPreco(pr);
        this.setQuantidade(quant);
    }

    public LinhaEncomenda(LinhaEncomenda e) {
        this(e.getReferencia(), e.getDescricao(), e.getPreco(), e.getQuantidade(), e.getImposto(), e.getDescontoComercial());
    }

    public boolean equals(LinhaEncomenda e) {
        if (this == e) return true;

        if (e == null || this.getClass() != e.getClass()) return false;

        return this.getReferencia().equals(e.getReferencia()) &&
                this.getDescricao().equals(e.getDescricao()) &&
                this.getPreco() == e.getPreco() &&
                this.getQuantidade() == e.getQuantidade() &&
                this.getImposto() == e.getImposto() &&
                this.getDescontoComercial() == e.getDescontoComercial();
    }

    public double calculaValorLinhaEncomenda() {
        double preco = this.getPreco() - this.calculaValorDesconto();
        return preco + preco * this.getImposto();
    }

    public double calculaValorDesconto() {
        return this.getDescontoComercial() * this.getPreco();
    }

    // sets e gets
    public String getReferencia() {
        return this.referencia;
    }
    public String getDescricao() {
        return this.descricao;
    }
    public double getPreco() {
        return this.preco;
    }
    public double getImposto() {
        return this.imposto;
    }
    public double getDescontoComercial() {
        return this.descontoComercial;
    }
    public int getQuantidade() {
        return this.quantidade;
    }

    public void setReferencia(String ref) {
        this.referencia = new String(ref);
    }
    public void setDescricao(String des) {
        this.descricao = new String(des);
    }
    public void setPreco(double pre) {
        this.preco = pre;
    }
    public void setQuantidade(int q) {
        this.quantidade = q;
    }
    public void setImposto(double im) {
        this.imposto = im;
    }
    public void setDescontoComercial(double desc) {
        this.descontoComercial = desc;
    }
}