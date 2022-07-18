package exercicios;

import java.util.ArrayList;

/**
 * Classe Veiculo, para utilizaçao na Ficha 6.
 * * @author MaterialPOO
 * @version 20210420
 */

public abstract class Veiculo implements Comparable<Veiculo> {
    private String marca;
    private String modelo;
    private String matricula;
    private int ano;
    private double velociademedia;
    private double precokm;
    private ArrayList<Integer> classificacao;
    private int kms;
    private int kmsUltimo; // kms da ultima viagem

    public String toString() {
        StringBuilder sb = new StringBuilder();

        sb.append("Marca: "); sb.append(this.marca);
        sb.append("\nModelo: "); sb.append(this.modelo);
        sb.append("\nMatricula: "); sb.append(this.matricula);
        sb.append("\nAno: "); sb.append(this.ano);
        sb.append("\nVelocidade Media: "); sb.append(this.velociademedia);
        sb.append("\nPreço p/ km: "); sb.append(this.precokm);
        sb.append("\nClassificaçoes: "); sb.append(this.classificacao);
        sb.append("\nKms: "); sb.append(this.kms);
        sb.append("\nKms da ultima viagem: "); sb.append(this.kmsUltimo);

        return sb.toString();
    }
    public abstract Veiculo clone();
    public void setMarca(String marc) {
        this.marca = marc;
    }
    public void setModelo(String mod) {
        this.modelo = mod;
    }
    public void setMatricula(String mat) {
        this.matricula = mat;
    }
    public void setAno(int a) {
        this.ano = a;
    }
    public void setClassificacao(ArrayList<Integer> cla) {
        this.classificacao = new ArrayList<Integer>(cla);
    }
    public void setKms(int km) {
        this.kms = km;
    }
    public void setKmsUltimo(int km) {
        this.kmsUltimo = km;
    }
    public String getMarca() {
        return marca;
    }
    public String getMatricula() {
        return matricula;
    }
    public String getModelo() {
        return modelo;
    }
    public int getAno() {
        return ano;
    }
    public double getVelociademedia() {
        return velociademedia;
    }
    public double getPrecokm() {
        return precokm;
    }
    public ArrayList<Integer> getClassificacao() {
        return new ArrayList<>(classificacao);
    }
    public int getKms() {
        return kms;
    }
    public int getKmsUltimo() {
        return kmsUltimo;
    }
    public void setVelociademedia(double velociademedia) {
        this.velociademedia = velociademedia;
    }
    public void setPrecokm(double precokm) {
        this.precokm = precokm;
    }

    // Fim dos setters e getters

    public void addViagem(int nkms) {
        this.kms += nkms;
        this.kmsUltimo = nkms;
    }

    public abstract double custoRealKM();

    public int classificacao(){
        return (int) this.classificacao.stream().mapToInt(k-> k).average().getAsDouble();
    }

    public void addClassificacao(int v){
        this.classificacao.add(v);
    }

    public boolean equals(Object o){
        if (o == this) return true;
        if (o == null || ! o.getClass().equals(this.getClass())) return false;
        Veiculo v = (Veiculo) o;
        return  this.marca.equals(v.getMarca()) &&
                this.modelo.equals(v.getModelo())&&
                this.matricula.equals(v.getMatricula()) &&
                this.ano == v.getAno() &&
                this.velociademedia == v.getVelociademedia() &&
                this.precokm == v.getPrecokm() &&
                this.classificacao.equals(v.getClassificacao()) &&
                this.kms == v.getKms() &&
                this.kmsUltimo == v.getKmsUltimo() ;
    }

    public int compareTo(Veiculo v) {
        if(this.marca.compareTo(v.getMarca()) == 0)
            if (this.modelo.compareTo(v.getModelo()) == 0)
                return this.matricula.compareTo(v.matricula);
            else return this.modelo.compareTo(v.getModelo());
        else
            return (this.marca.compareTo(v.getMarca()));
    }
}