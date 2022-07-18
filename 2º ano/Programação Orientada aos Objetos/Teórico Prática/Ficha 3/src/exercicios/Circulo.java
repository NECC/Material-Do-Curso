package exercicios;

import java.lang.Math;

public class Circulo {

    private double x;
    private double y;
    private double raio;

    /** */
    public Circulo(double xNovo, double yNovo, double raioNovo) {
        this.x = xNovo;
        this.y = yNovo;
        this.raio = raioNovo;
    }

    /** */
    public Circulo() {
        /*
        this.x = this.y = 0;
        this.raio = 1;
         */
        this(0,0,1);
    }

    /** */
    public Circulo(Circulo c) {
        /*
        this.x = c.x;
        this.y = c.y;
        this.raio = c.raio;
        */
        this(c.getX(), c.getY(), c.getRaio());
    }

    /** */
    public Circulo clone() {
        return new Circulo(this);
    }

    /** */
    public boolean equals(Object c) {
        if (this == c) return true;

        if (c == null || c.getClass() != this.getClass()) return false;
        Circulo p = (Circulo) c;

        return this.x == p.x && this.y == p.y && this.raio == p.raio;
    }

    /** */
    public String toString() {
        return "x: " + this.x + "\ny: " + this.y + "\nRaio: " + this.raio;
    }

    /** */
    public double getX() {
        return this.x;
    }

    /** */
    public double getY() {
        return this.y;
    }

    /** */
    public double getRaio() {
        return this.raio;
    }

    /** */
    public void setX(double xNovo) {
        this.x = xNovo;
    }

    /** */
    public void setY(double yNovo) {
        this.y = yNovo;
    }

    /** */
    public void setRaio(double raioNovo) {
        this.raio = raioNovo;
    }

    /** */
    public void alteraCentro(double xNovo, double yNovo) {
        this.x = xNovo;
        this.y = yNovo;
    }

    /** */
    public double calculaArea() {
        return Math.PI * this.raio * this.raio;
    }

    /** */
    public double calculaPerimetro() {
        return Math.PI * 2 * this.raio;
    }
}
