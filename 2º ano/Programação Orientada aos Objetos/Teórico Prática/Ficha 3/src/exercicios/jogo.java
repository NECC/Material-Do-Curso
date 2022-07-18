package exercicios;

public class jogo {
    private static final int porIniciar = 0;
    private static final int aDecorrer = 1;
    private static final int terminado = 2;

    private int estadoJogo; // 0 -> por iniciar, 1 -> a decorrer, 2 -> terminado
    private int golosVisitada;
    private int golosVisitante;
    private String equipaVisitada;
    private String equipaVisitante;

    public jogo() {
        this("Sem nome atribuido", "Sem nome atribuido");
    }

    public jogo(String e1, String e2) {
        this.setEstadoJogo(porIniciar);
        this.setEquipaVisitada(e1);
        this.setEquipaVisitante(e2);
    }

    public void startGame() {
        if (this.getEstadoJogo() == porIniciar) {
            this.setEstadoJogo(aDecorrer);
            this.setGolosVisitada(0);
            this.setGolosVisitante(0);
        }
    }

    public void endGame() {
        if (this.getEstadoJogo() == aDecorrer)
            this.setEstadoJogo(terminado);
    }

    public void goloVisitado() {
        if (this.getEstadoJogo() == aDecorrer) {
            this.setGolosVisitada(this.getGolosVisitada() + 1);
        }
    }

    public void goloVisitante() {
        if (this.getEstadoJogo() == aDecorrer) {
            this.setGolosVisitante(this.getGolosVisitante() + 1);
        }
    }

    public String resultadoAtual() {
        return this.getEquipaVisitada() + " " + this.getGolosVisitada() + " - " + this.getEquipaVisitante() + " " + this.getGolosVisitante();
    }

    public String toString() {
        return "Estado de jogo: " + this.getEstadoJogo() + "\nResultado: " + this.resultadoAtual();
    }

    // sets e gets
    public void setEstadoJogo(int e) {
        this.estadoJogo = e;
    }

    public void setGolosVisitada(int g) {
        this.golosVisitada = g;
    }

    public void setGolosVisitante(int g) {
        this.golosVisitante = g;
    }

    public int getEstadoJogo() {
        return this.estadoJogo;
    }

    public int getGolosVisitada() {
        return this.golosVisitada;
    }

    public int getGolosVisitante() {
        return this.golosVisitante;
    }

    public String getEquipaVisitada() {
        return this.equipaVisitada;
    }

    public String getEquipaVisitante() {
        return this.equipaVisitante;
    }

    public void setEquipaVisitada(String nome) {
        this.equipaVisitada = new String(nome);
    }

    public void setEquipaVisitante(String nome) {
        this.equipaVisitante = new String(nome);
    }
}
