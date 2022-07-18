package ex1;

public class Lugar implements Comparable<Lugar>{
    /** Matricula do veicullo estacionado */
    private String matricula;
    /** Nome do proprietario */
    private String nome;
    /** Tempo atribuido ao lugar, em minutos */
    private int minutos;
    /** Indica se o lugar e permanente, ou de aluguer */
    private boolean permanente;

    public Lugar() {
        this.matricula = "";
        this.nome = "";
        this.minutos = 0;
        this.permanente = true;
    }

    public Lugar(String mat, String nom, int min, boolean perm) {
        this.matricula = mat;
        this.nome = nom;
        this.minutos = min;
        this.permanente = perm;
    }

    public Lugar(Lugar l) {
        this(l.matricula, l.nome, l.minutos, l.permanente);
    }

    public boolean equals(Object o) {
        if (this == o) return true;

        if (o == null || this.getClass() != o.getClass()) return false;

        Lugar l = (Lugar) o;
        return this.matricula.equals(l.matricula) &&
                this.nome.equals(l.nome) &&
                this.minutos == l.minutos &&
                this.permanente == l.permanente;
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();

        sb.append("Matricula: "); sb.append(this.matricula);
        sb.append("\nNome do proprietario: "); sb.append(this.nome);
        sb.append("\nMinutos alocados para o lugar: "); sb.append(this.minutos);
        sb.append("\nLugar permanente: "); sb.append(this.permanente);

        return sb.toString();
    }

    public Lugar clone() {
        return new Lugar(this);
    }

    public int compareTo(Lugar lugar) {
        return this.minutos - lugar.minutos;
    }

    // setters e getters
    public void setNome(String nom) {
        this.nome = nom;
    }
    public void setMatricula(String mat) {
        this.matricula = mat;
    }
    public void setMinutos(int min) {
        this.minutos = min;
    }
    public void setPermanente(boolean p) {
        this.permanente = p;
    }
    public String getNome() {
        return this.nome;
    }
    public String getMatricula() {
        return this.matricula;
    }
    public int getMinutos() {
        return this.minutos;
    }
    public boolean isPermanente() {
        return this.permanente;
    }

}
