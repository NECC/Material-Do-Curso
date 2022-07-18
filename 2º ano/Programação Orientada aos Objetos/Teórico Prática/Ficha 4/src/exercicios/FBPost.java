package exercicios;

import java.time.LocalDateTime;
import java.util.ArrayList;

public class FBPost{
    private int id;
    private String utilizador;
    private LocalDateTime data;
    private String conteudo;
    private int likes;
    private ArrayList<String> comentarios;

    public FBPost(int iden, String user, LocalDateTime instante, String cont, int lik, ArrayList<String> comments) {
        this.id = iden;
        this.utilizador = user;
        this.data = LocalDateTime.of(instante.toLocalDate(), instante.toLocalTime());
        this.conteudo = cont;
        this.likes = lik;
        this.comentarios = new ArrayList<String>(comments);
    }

    public FBPost() {
        this(123456,"Unknown", LocalDateTime.now(), "", 0, new ArrayList<String>());
    }

    public FBPost(FBPost f) {
        this(f.id, f.utilizador, f.data, f.conteudo, f.likes, f.comentarios);
    }

    public FBPost clone() {
        return new FBPost(this);
    }

    public boolean equals(Object o) {
        if (this == o) return true;

        if (o == null || this.getClass() != o.getClass()) return false;

        FBPost fbp = (FBPost) o;
        return this.id == fbp.id &&
                this.utilizador.equals(fbp.utilizador) &&
                this.data.equals(fbp.data) &&
                this.conteudo.equals(fbp.conteudo) &&
                this.likes == fbp.likes &&
                this.comentarios.equals(fbp.comentarios); //Este equals do arraylist acho que so verifica as referencias
    }

    // setters e getters
    public void setId(int i) {
        this.id = i;
    }
    public void setUtilizador(String u) {
        this.utilizador = u;
    }
    public void setData(LocalDateTime d) {
        this.data = LocalDateTime.of(d.toLocalDate(), d.toLocalTime());
    }
    public void setConteudo(String c) {
        this.conteudo = c;
    }
    public void setLikes(int l) {
        this.likes = l;
    }
    public void setComentarios(ArrayList<String> c) {
        this.comentarios = new ArrayList<String>(c);
    }

    public int getId() {
        return this.id;
    }
    public String getUtilizador() {
        return this.utilizador;
    }
    public LocalDateTime getData() {
        return LocalDateTime.of(this.data.toLocalDate(), this.data.toLocalTime());
    }
    public String getConteudo() {
        return this.conteudo;
    }
    public int getLikes() {
        return this.likes;
    }
    public ArrayList<String> getComentarios() {
        return new ArrayList<String>(this.comentarios);
    }
}
