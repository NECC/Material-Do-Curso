package exercicios;

import java.time.LocalDateTime;

public class Lampada {
    private static final int MAXIMO = 100;
    private static final int ECO = 50;
    private static final int OFF = 0;

    private int consumo;
    private int consumoTotal;
    private long tempo;

    public Lampada() {
        this.setConsumo(OFF);
    }

    public Lampada(int con, int total) {
        this.setConsumo(con);
        this.consumoTotal = total;
    }

    public Lampada(Lampada l) {
        this(l.getConsumo(), l.getConsumoTotal());
    }

    public boolean equals(Lampada l) {
        if (this == l) return true;

        if (l == null || l.getClass() == this.getClass()) return false;

        return this.consumo == l.consumo;
    }

    public Lampada clone() {
        return new Lampada(this);
    }

    public void lampON() {
        if (this.getConsumo() != OFF) {
            this.setConsumoTotal((int) (this.getConsumoTotal() + this.getConsumo() * (System.currentTimeMillis() - this.getTempo())));
        }
        this.setConsumo(MAXIMO);
        this.setTempo(System.currentTimeMillis());
    }

    public void lampOFF() {
        if (this.getConsumo() != OFF) {
            this.setConsumoTotal((int) (this.getConsumoTotal() + this.getConsumo() * (System.currentTimeMillis() - this.getTempo())));
        }
        this.setConsumo(OFF);
        this.setTempo(System.currentTimeMillis());
    }

    public void lampECO() {
        if (this.getConsumo() != OFF) {
            this.setConsumoTotal((int) (this.getConsumoTotal() + this.getConsumo() * (System.currentTimeMillis() - this.getTempo())));
        }
        this.setConsumo(ECO);
        this.setTempo(System.currentTimeMillis());
    }

    public double totalConsumo() {
        return this.getConsumoTotal();
    }

    public double periodoConsumo() {
        return this.getConsumo() * (System.currentTimeMillis() - this.getTempo());
    }

    // sets e gets
    public int getConsumo() {
        return this.consumo;
    }

    public int getConsumoTotal() {
        return this.consumoTotal;
    }

    public long getTempo() {
        return this.tempo;
    }

    public void setTempo(long data) {
        this.tempo = data;
    }

    public void setConsumoTotal(int con) {
        this.consumoTotal = con;
    }

    public void setConsumo(int con) {
        this.consumo = con;
    }

    public int getECO() {
        return ECO;
    }

    public int getMaximo() {
        return MAXIMO;
    }

    public int getOff() {
        return OFF;
    }
}