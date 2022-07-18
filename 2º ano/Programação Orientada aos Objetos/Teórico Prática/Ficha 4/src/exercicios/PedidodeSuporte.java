package exercicios;

import java.time.LocalDateTime;

public class PedidodeSuporte {
    private String nome;
    private LocalDateTime data;
    private String assunto;
    private String descricao;

    private String tratado;
    private LocalDateTime dataTratado;
    private String resposta;

    public PedidodeSuporte(String nome, LocalDateTime data, String assunto, String descricao, String tratado, LocalDateTime dataTratado, String resposta) {
        this.nome = nome;
        this.data = LocalDateTime.of(data.toLocalDate(), data.toLocalTime());
        this.assunto = assunto;
        this.descricao = descricao;
        this.tratado = tratado;
        this.dataTratado = LocalDateTime.of(dataTratado.toLocalDate(), dataTratado.toLocalTime());
        this.resposta = resposta;
    }

    public PedidodeSuporte() {
        this("",LocalDateTime.now(), "", "", "", LocalDateTime.now(), "");
    }

    public PedidodeSuporte(PedidodeSuporte p) {
        this(p.nome, p.data, p.assunto, p.descricao, p.tratado, p.dataTratado, p.resposta);
    }

    public boolean equals(Object o) {
        if (this == o) return true;

        if (o == null || this.getClass() != o.getClass()) return false;

        PedidodeSuporte p = (PedidodeSuporte) o;
        return this.nome.equals(p.nome) &&
                this.data.equals(p.data) &&
                this.assunto.equals(p.assunto) &&
                this.descricao.equals(p.descricao) &&
                this.tratado.equals(p.tratado) &&
                this.dataTratado.equals(p.dataTratado) &&
                this.resposta.equals(p.resposta);
    }

    public PedidodeSuporte clone() {
        return new PedidodeSuporte(this);
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();

        sb.append("Pedido submetido por: "); sb.append(this.nome);
        sb.append("\nSubmetido em: "); sb.append(this.data);
        sb.append("\nAssunto: "); sb.append(this.assunto);
        sb.append("\nDescriçao: "); sb.append(this.descricao);
        sb.append("\nTratado por: "); sb.append(this.tratado);
        sb.append("\nTratado em: "); sb.append(this.dataTratado);
        sb.append("\nResposta: "); sb.append(this.resposta);

        return sb.toString();
    }

    // setters e getters
    public String getNome() {
        return this.nome;
    }
    public LocalDateTime getDate() {
        return LocalDateTime.of(this.data.toLocalDate(), this.data.toLocalTime());
    }
    public String getAssunto() {
        return this.assunto;
    }
    public String getDescricao() {
        return this.descricao;
    }
    public String getTratado() {
        return this.tratado;
    }
    public LocalDateTime getDataTratado() {
        return LocalDateTime.of(this.dataTratado.toLocalDate(), this.dataTratado.toLocalTime());
    }
    public String getResposta() {
        return this.resposta;
    }

    public void setNome(String n) {
        this.nome = n;
    }
    public void setData(LocalDateTime dt) {
        this.data = LocalDateTime.of(dt.toLocalDate(), dt.toLocalTime());
    }
    public void setAssunto(String a) {
        this.assunto = a;
    }
    public void setDescricao(String d) {
        this.descricao = d;
    }
    public void setTratado(String t) {
        this.tratado = t;
    }
    public void setDataTratado(LocalDateTime dt) {
        this.dataTratado = LocalDateTime.of(dt.toLocalDate(), dt.toLocalTime());
    }
    public void setResposta(String r) {
        this.resposta = r;
    }


}
