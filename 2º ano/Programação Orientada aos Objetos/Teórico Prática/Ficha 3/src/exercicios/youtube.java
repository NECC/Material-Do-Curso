package exercicios;

import java.time.LocalDateTime;
import java.util.Arrays;

import java.time.temporal.ChronoUnit;

public class youtube {
    private static final int likes = 0;
    private static final int dislikes = 1;
    private static final int minutos = 0;
    private static final int segundos = 1;

    private String nomeVideo;
    private char[] video;
    private LocalDateTime data;
    private int resolucao;
    private int[] duracao;
    private String[] comentarios;
    private int[] reactions;

    public youtube() {
        this.nomeVideo = "[Insert Name Here]";
        this.video = new char[0];
        this.data = LocalDateTime.now();
        this.resolucao = 1080;
        this.duracao[minutos] = 0;
        this.duracao[segundos] = 0;
        this.comentarios = new String[0];
        this.reactions[likes] = 0;
        this.reactions[dislikes] = 0;
    }

    public youtube(String nome, char[] video, int resol, int min, int sec) {
        this.nomeVideo = new String(nome);
        this.video = new char[video.length];
        System.arraycopy(video, 0, this.video, 0, video.length);
        this.resolucao = resol;
        this.duracao[minutos] = min;
        this.duracao[segundos] = sec;
        this.reactions[likes] = this.reactions[dislikes] = 0;
        this.comentarios = new String[0];
    }

    public boolean equals(youtube v) {
        if (this == v) return true;

        if (v == null || v.getClass() != this.getClass()) return false;

        return this.nomeVideo.equals(v.nomeVideo) && Arrays.equals(this.video, v.video) &&
                this.resolucao == v.resolucao && Arrays.equals(this.duracao, v.duracao) &&
                Arrays.equals(this.reactions, v.reactions);
    }

    public String toString() {
        return "Video: " + this.getNomeVideo() + "\nDuraçao: " + this.getMinutos() + "minutos e " + this.getSegundos() + "segundos" +
                "\nLikes: " + this.getLikes() + "\nDislikes: "+ this.getDislikes();
    }

    public void insereComentario(String coment) {
        String[] coms = this.getComentarios();
        String[] novo = new String[coms.length + 1];
        System.arraycopy(coms, 0, novo, 0, coms.length);
        novo[coms.length] = new String(coment);
        this.setComentarios(novo);
    }

    public long qtsDiasDepois() {
        LocalDateTime lancamento = this.getData();
        LocalDateTime atual = LocalDateTime.now();

        return ChronoUnit.DAYS.between(lancamento, atual);
    }

    public void thumbsUp() {
        int n = this.getLikes();
        this.setLikes(n+1);
    }

    public String processa() {
        StringBuilder s = new StringBuilder();
        char[] vid = this.getVideo();

        for (char c : vid) s.append(c);

        return s.toString();
    }

    // sets e gets
    public int getLikes() {
        return this.reactions[likes];
    }
    public int getDislikes() {
        return this.reactions[dislikes];
    }
    public String getNomeVideo() {
        return this.nomeVideo;
    }
    public char[] getVideo() {
        char[] novo = new char[this.video.length];
        System.arraycopy(this.video, 0, novo, 0, this.video.length);
        return novo;
    }
    public int getResolucao() {
        return this.resolucao;
    }
    public int getMinutos() {
        return this.duracao[minutos];
    }
    public int getSegundos() {
        return this.duracao[segundos];
    }
    public String[] getComentarios() {
        String[] novo = new String[this.comentarios.length];
        System.arraycopy(this.comentarios, 0, novo, 0, this.comentarios.length);
        return novo;
    }
    public LocalDateTime getData() {
        return this.data;
    }

    public void setLikes(int l) {
        this.reactions[likes] = l;
    }
    public void setDislikes(int d) {
        this.reactions[dislikes] = d;
    }
    public void setNomeVideo(String nome) {
        this.nomeVideo = new String(nome);
    }
    public void setVideo(char[] vid) {
        this.video = new char[video.length];
        System.arraycopy(vid, 0, this.video, 0, video.length);
    }
    public void setResolucao(int re) {
        this.resolucao = re;
    }
    public void setMinutos(int m) {
        this.reactions[minutos] = m;
    }
    public void setSegundos(int s) {
        this.reactions[segundos] = s;
    }
    public void setComentarios(String[] com) {
        this.comentarios = new String[com.length];
        System.arraycopy(com, 0, this.comentarios, 0, com.length);
    }
    }
