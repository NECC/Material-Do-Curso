package exercicios;

public class Carro {
    private String marca;
    private String modelo;
    private int anoConstrucao;
    private double consumoKmH;
    private int kms;
    private double mediaConsumo;
    private int kmsRecentes;
    private double mediaConsumoRecente;
    private int regeneracao;

    public Carro(String mar, String mod, int ano, double cons, int reg) {
        this.setMarca(mar);
        this.setModelo(mod);
        this.setAnoConstrucao(ano);
        this.setConsumoKmH(cons);
        this.setRegeneracao(reg);
        this.setKms(0);
        this.setKmsRecentes(0);
        this.setMediaConsumo(0);
        this.setMediaConsumoRecente(0);
    }

    public Carro() {
        this("Nao declarado", "Nao declarado", 1970, 5.5, 1);
    }

    public Carro(Carro c) {
        this(c.getMarca(), c.getModelo(), c.getAnoConstrucao(), c.getConsumoKmH(), c.getRegeneracao());
    }

    public boolean equals(Carro c) {
        if (this == c) return true;

        if (c == null || this.getClass() != c.getClass()) return false;

        return this.getMarca().equals(c.getMarca()) && this.getModelo().equals(c.getModelo()) &&
                this.getAnoConstrucao() == c.getAnoConstrucao() && this.getConsumoKmH() == c.getConsumoKmH() &&
                this.getKms() == c.getKms() && this.getKmsRecentes() == c.getKmsRecentes() && this.getMediaConsumo() == c.getMediaConsumo() &&
                this.getMediaConsumoRecente() == c.getMediaConsumoRecente() && this.getRegeneracao() == c.getRegeneracao();
    }

    public Carro clone() {
        return new Carro(this);
    }

    public String toString() {
        return "Marca: " + this.getMarca() + "\nModelo: " + this.getModelo() + "\nAno de Construçao: " + this.getAnoConstrucao() +
                "\nConsumo km/h: " + this.getConsumoKmH() + "\nkms: " + this.getKms() + "\nMedia de consumo: " + this.getMediaConsumo() +
                "\nkms recentes: " + this.getKmsRecentes() + "\nMedia de consumo recente: " + this.getMediaConsumoRecente() +
                "\nRegeneraçao: " + this.getRegeneracao();
    }

    // sets e gets
    public void setMarca(String marc) {
        this.marca = new String(marc);
    }
    public void setModelo(String mod) {
        this.modelo = new String(mod);
    }
    public void setAnoConstrucao(int ano) {
        this.anoConstrucao = ano;
    }
    public void setConsumoKmH(double cons) {
        this.consumoKmH = cons;
    }
    public void setKms(int kms) {
        this.kms = kms;
    }
    public void setMediaConsumo(double media) {
        this.mediaConsumo = media;
    }
    public void setKmsRecentes(int kmsRec) {
        this.kmsRecentes = kmsRec;
    }
    public void setMediaConsumoRecente(double media) {
        this.mediaConsumoRecente = media;
    }
    public void setRegeneracao(int reg) {
        this.regeneracao = reg;
    }

    public String getMarca() {
        return this.marca;
    }
    public String getModelo() {
        return this.modelo;
    }
    public int getAnoConstrucao() {
        return this.anoConstrucao;
    }
    public int getConsumoKmH() {
        return (int) this.consumoKmH;
    }
    public int getKms() {
        return this.kms;
    }
    public int getMediaConsumo() {
        return (int) this.mediaConsumo;
    }
    public int getKmsRecentes() {
        return this.kmsRecentes;
    }
    public int getMediaConsumoRecente() {
        return (int) this.mediaConsumoRecente;
    }
    public int getRegeneracao() {
        return this.regeneracao;
    }
}