package exercicios;

import java.util.ArrayList;
import java.util.stream.Collectors;

public class CasaInteligente {
    private ArrayList<Lampada> lista;

    public CasaInteligente() {
        lista = new ArrayList<Lampada>();
    }

    public CasaInteligente(CasaInteligente c) {
        this(c.lista);
    }

    public CasaInteligente(ArrayList<Lampada> lis) {
        this.lista = lis.stream().map(Lampada::clone).collect(Collectors.toCollection(ArrayList::new));
    }

    public CasaInteligente clone() {
        return new CasaInteligente(this);
    }

    public boolean equals(Object o) {
        if (this == o) return true;

        if (o == null || this.getClass() != o.getClass()) return false;

        CasaInteligente c = (CasaInteligente) o;
        return this.lista.equals((c.lista));
    }

    public String toString() {
        StringBuilder sb = new StringBuilder("Lampadas: \n");

        for (Lampada elem : this.lista){
            sb.append(elem.toString());
            sb.append("\n");
        }
        return sb.toString();
    }

    public void addLampada(Lampada l) {
        this.lista.add(l.clone());
    }

    public void ligaLampadaNormal(int index) {
        if (index <= this.lista.size()) {
            Lampada l = this.lista.get(index);
            l.lampON();
            this.lista.set(index, l);
        }
    }

    public void ligaLampadaECO(int index) {
        if (index <= this.lista.size()) {
            Lampada l = this.lista.get(index);
            l.lampECO();
            this.lista.set(index, l);
        }
    }

    public int qtEmECO() {
        ArrayList<Lampada> lis = new ArrayList<Lampada>(this.lista);
        return (int) lis.stream().filter(a->a.getConsumo() == a.getECO()).count();
    }

    public void removeLampada(int index) {
        if (index < this.lista.size()) {
            this.lista.remove(index);
        }
    }

    public void ligaTodasECO() {
        this.lista.forEach(Lampada::lampECO);
    }

    public void ligaTodasMax() {
        this.lista.forEach(Lampada::lampON);
    }

    public double consumoTotal() {
        ArrayList<Lampada> lis = new ArrayList<Lampada>(this.lista);
        return lis.stream().mapToDouble(Lampada::getConsumo).sum();
    }

    public void reset() {
        this.lista.forEach(a-> {
            a.setConsumoTotal((int) (a.getConsumoTotal() + a.getConsumo() * (System.currentTimeMillis() - a.getTempo())));
            a.setTempo(System.currentTimeMillis());
        });
    }

}
