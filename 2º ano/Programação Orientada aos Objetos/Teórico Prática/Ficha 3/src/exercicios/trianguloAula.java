package exercicios;

public class trianguloAula {
    private Ponto a;
    private Ponto b;
    private Ponto c;

    public trianguloAula(Ponto a, Ponto b, Ponto c) {
        this.a = a.clone();
        this.b = b.clone();
        this.c = c.clone();
    }

    public trianguloAula() {
        this.a = new Ponto(0,0);
        this.b = new Ponto(0,1);
        this.c = new Ponto(1,0);
    }

    public trianguloAula(trianguloAula t) {
        this(t.a, t.b, t.c);
    }

    public trianguloAula clone() {
        return new trianguloAula(this);
    }

    public boolean equals(Object o) {
        if (o == this) return true;

        if (o == null || o.getClass() != this.getClass()) return false;

        trianguloAula t = (trianguloAula) o;
        // return this.a.equals(t.getA()) && this.b.equals(t.getB()) && this.c.equals(t.getC());

        Ponto[] ar = new Ponto[]{a,b,c};
        Ponto[] ar2 = new Ponto[]{t.getA(),t.getB(),t.getC()};
        boolean enc = true;
        int k = 3;
        for (int i = 0; i < 3 && enc; i++) {
            enc = false;
            for (int j = 0; j < k; j++) {
                if (ar[i].equals(ar2[j])) {
                    enc = true;
                    ar2[j] = ar2[--k];
                    break;
                }
            }
        }
        return enc;
    }

    public String toString() {
        return "Triangulo: " +
                "\nPonto 1: " + a.toString() +
                "\nPonto 2: " + b.toString() +
                "\nPonto 3: " + c.toString();
    }

    public double calculaPerimetroTriangulo() {
        return a.distancia(b) + b.distancia(c) + c.distancia(a);
    }

    public double calculaAreaTriangulo() {
        double p1 = a.distancia(b);
        double p2 = b.distancia(c);
        double p3 = c.distancia(a);
        double s = (p1+p2+p3) / 2;
        return Math.sqrt(s * (s-p1) * (s-p2) + (s-p3));
    }

    public int altura() {
        int min = Math.min(a.getY(), Math.min(b.getY(), c.getY()));
        int max = Math.max(a.getY(), Math.max(b.getY(), c.getY()));
        return max - min;
    }

    //sets e gets
    public Ponto getA() {
        return this.a.clone();
    }
    public Ponto getB() {
        return this.b.clone();
    }
    public Ponto getC() {
        return this.c.clone();
    }
    public void setA(Ponto x) {
        this.a = x.clone();
    }
    public void setB(Ponto x) {
        this.b = x.clone();
    }
    public void setC(Ponto x) {
        this.c = x.clone();
    }
}
