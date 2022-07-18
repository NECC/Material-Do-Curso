package exercicios;

public class telemovel {
    private String marca;
    private String modelo;
    private int xDisplay;
    private int yDisplay;
    // Dimensoes
    private int numeroMensagens;
    private String[] mensagens;
    private int armazenamento;
    private int armazenamentoFotos;
    private int armazenamentoApps;
    private int espacoOcupado;

    private int fotos;
    private int apps;
    private String[] appNomes;

    public telemovel(String marca, String modelo, int xD, int yD, int arm, int armF, int armA, int men) {
        this.marca = new String(marca);
        this.modelo = new String(modelo);
        this.xDisplay = xD;
        this.yDisplay = yD;
        this.numeroMensagens = men;
        this.armazenamento = arm;
        this.armazenamentoFotos = armF;
        this.armazenamentoApps = armA;
        this.espacoOcupado = 0;
        this.fotos = 0;
        this.apps = 0;
        this.appNomes = new String[armA];
        this.mensagens = new String[men];
    }

    public telemovel() {
        this("Nao declarada", "Nao declarado", 100, 100, 64, 32, 32, 10);
    }

    public String toString() {
        return "Marca: " + this.getMarca() +
                "\nModelo: " + this.getModelo() +
                "\nx Display: " + this.getxDisplay() +
                "\ny Display: " + this.getyDisplay() +
                "\nNumero de Mensagens: " + this.getNumeroMensagens() +
                "\nArmazenamento: " + this.getArmazenamento() +
                "\nArmazenamento de fotos: " + this.getArmazenamentoFotos() +
                "\nArmazenamento de apps: " + this.getArmazenamentoApps() +
                "\nEspaço Ocupado: " + this.getEspacoOcupado() +
                "\nNumero de fotos: " + this.getFotos() +
                "\nNumero de Apps: " + this.getApps();
    }

    public boolean equals(telemovel t) {
        if (t == this) return true;

        if (t == null || t.getClass() != this.getClass()) return false;

        return this.getMarca().equals(t.getMarca()) && this.getModelo().equals(t.getModelo()) &&
                this.getxDisplay() == t.getxDisplay() && this.getyDisplay() == t.getyDisplay() &&
                this.numeroMensagens == t.numeroMensagens && this.armazenamento == t.armazenamento &&
                this.armazenamentoApps == t.armazenamentoApps && this.armazenamentoFotos == t.armazenamentoFotos &&
                this.espacoOcupado == t.espacoOcupado && this.fotos == t.fotos && this.apps == t.apps;
    }

    public boolean existeEspaco(int numeroBytes) {
        return (this.getEspacoOcupado() + numeroBytes <= this.getArmazenamento());
    }

    public void instalaApp(String nome, int espaco) {
        if (existeEspaco(espaco) && this.getArmazenamentoApps() >= espaco) {
            int n = this.getApps();
            this.appNomes[n++] = new String(nome);
            this.setApps(n);
            this.setEspacoOcupado(this.getEspacoOcupado() + espaco);
            this.setArmazenamentoApps(this.getArmazenamentoApps() + espaco);
        }
    }

    public void recebeMensagem(String men) {
        int n = this.getNumeroMensagens() + 1;
        String[] novo = this.getMensagens();
        this.mensagens = new String[n];
        System.arraycopy(novo, 0, this.mensagens, 0, n-1);
        this.mensagens[n-1] = new String(men);
        this.setNumeroMensagens(n);
    }

    public double tamMedioApps() {
        double media = this.getArmazenamentoApps();
        media /= (double) this.getApps();
        return media;
    }

    public String maiorMsg() {
        String[] msg = this.getMensagens();
        if (this.getNumeroMensagens() < 1) return null;
        String mensagem = msg[0];
        int length = mensagem.length();

        for (int i = 1; i < this.getNumeroMensagens(); i++) {
            if (length < msg[i].length()) {
                mensagem= msg[i];
                length = mensagem.length();
            }
        }

        return mensagem;
    }

    public void removeApp(String nome, int tamanho) {
        String[] msg = this.getMensagens();
        int n = this.getNumeroMensagens();
        this.mensagens = new String[n - 1];
        boolean enc = false;
        for (int i = 0, p = 0; i < n; i++) {
            if (msg[i].equals(nome)) {
                enc = true;
            } else this.mensagens[p++] = msg[i];
        }
        if (enc) {
            this.setNumeroMensagens(n-1);
        }
    }

    // sets e gets
    public String getMarca() {
        return this.marca;
    }
    public String getModelo() {
        return this.modelo;
    }
    public int getxDisplay() {
        return this.xDisplay;
    }
    public int getyDisplay() {
        return this.yDisplay;
    }
    public int getNumeroMensagens() {
        return this.numeroMensagens;
    }
    public int getArmazenamento() {
        return this.armazenamento;
    }
    public int  getArmazenamentoFotos() {
        return this.armazenamentoFotos;
    }
    public int getArmazenamentoApps() {
        return this.armazenamentoApps;
    }
    public int getEspacoOcupado() {
        return this.espacoOcupado;
    }
    public int getFotos() {
        return this.fotos;
    }
    public int getApps() {
        return this.apps;
    }
    public String[] getAppNomes() {
        String[] novo = new String[this.apps];

        if (this.apps >= 0) System.arraycopy(this.appNomes, 0, novo, 0, this.apps);

        return novo;
    }
    public String[] getMensagens() {
        String[] novo = new String[this.numeroMensagens];

        if (this.numeroMensagens >= 0) System.arraycopy(this.mensagens, 0, novo, 0, this.numeroMensagens);

        return novo;
    }

    public void setMarca(String mar) {
        this.marca = new String(mar);
    }
    public void setModelo(String mod) {
        this.modelo = new String(mod);
    }
    public void setxDisplay(int x) {
        this.xDisplay = x;
    }
    public void setyDisplay(int y) {
        this.yDisplay = y;
    }
    public void setNumeroMensagens(int x) {
        this.numeroMensagens = x;
    }
    public void setArmazenamento(int ar) {
        this.armazenamento = ar;
    }
    public void setArmazenamentoFotos(int af) {
        this.armazenamentoFotos = af;
    }
    public void setArmazenamentoApps(int aa) {
        this.armazenamentoApps = aa;
    }
    public void setEspacoOcupado(int eO) {
        this.espacoOcupado = eO;
    }
    public void setFotos(int f) {
        this.fotos = f;
    }
    public void setApps(int a) {
        this.apps = a;
    }
}
