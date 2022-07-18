package exercicios;

public class Triangulo {
    private double[] x;
    private double[] y;
    private double[] z;

    public Triangulo() {
        this(new double[]{0, 0},new double[]{0, 0},new double[]{0, 0});
    }

    public Triangulo(double[] a, double[] b, double[] c) {
        this.setX(a);
        this.setX(b);
        this.setX(c);
    }

    public Triangulo(Triangulo t) {
        this(t.x,t.y,t.z);
    }

    private double dist(double[] a, double[] b) {
        return Math.sqrt((a[0] - a[1])*(a[0] - a[1]) + (b[0] - b[1])*(b[0] - b[1]));
    }

    public double calculaAreaTriangulo() {
        double[] a = this.getX();
        double[] b = this.getY();
        double[] c = this.getZ();
        return 0.5 * ((a[0] * (b[1] - c[1])) + b[0] * (c[1] - a[1]) + c[0] * (a[1] - b[1])); //Nao sei se esta certa, encontrei a formula
    }

    public double calculaPerimetroTriangulo() {
        double[] a = this.getX();
        double[] b = this.getY();
        double[] c = this.getZ();
        return dist(a,b) + dist(b,c) + dist(c,a);
    }

    public double calculaAltura() {
        double[] a = this.getX();
        double[] b = this.getY();
        double[] c = this.getZ();
        double min = Math.min(a[1], Math.min(b[1], c[1]));
        double max = Math.max(a[1], Math.max(b[1], c[1]));
        return max - min;
    }

    // sets e gets
    public void setX(double[] a) {
        this.x = new double[2];
        this.x[0] = a[0];
        this.x[1] = a[1];
    }
    public void setY(double[] a) {
        this.y = new double[2];
        this.y[0] = a[0];
        this.y[1] = a[1];
    }
    public void setZ(double[] a) {
        this.z = new double[2];
        this.z[0] = a[0];
        this.z[1] = a[1];
    }

    public double[] getX() {
        double[] ar = new double[2];
        ar[0] = this.x[0];
        ar[1] = this.x[1];
        return ar;
    }
    public double[] getY() {
        double[] ar = new double[2];
        ar[0] = this.y[0];
        ar[1] = this.y[1];
        return ar;
    }
    public double[] getZ() {
        double[] ar = new double[2];
        ar[0] = this.z[0];
        ar[1] = this.z[1];
        return ar;
    }
}
