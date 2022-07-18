package ex1;

import java.util.*;
import java.util.stream.Collectors;

public class Parque {
    private String nomeParque;
    private Map<String, Lugar> lugares;

    public Parque() {
        this.nomeParque = "";
        this.lugares = Collections.EMPTY_MAP;
    }

    public Parque(String nome, Map<String, Lugar> mapa) {
        this.nomeParque = nome;
        this.lugares = mapa.values().stream().collect(Collectors.toMap(Lugar::getMatricula, Lugar::clone));
    }

    public Parque(Parque p) {
        this(p.nomeParque, p.lugares);
    }

    public Parque clone() {
        return new Parque(this);
    }

    public boolean equals(Object o) {
        if (this == o) return true;

        if (o == null || this.getClass() != o.getClass()) return false;

        Parque p = (Parque) o;
        return this.nomeParque.equals(p.nomeParque) &&
                this.lugares.equals(p.lugares);
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();

        sb.append("Nome do parque: "); sb.append(this.nomeParque);
        if (this.lugares.isEmpty()) sb.append("Parque vazio");
        else {
            sb.append("Lugares: ");
            this.lugares.values().forEach(l-> {
                sb.append(l.toString());
                sb.append("\n");
            });
        }

        return sb.toString();
    }

    public Set<String> matriculas() {
        return this.lugares.keySet();
    }

    public void novaOcupacao(String mat, String nom, int min, boolean perm) {
        this.lugares.put(mat, new Lugar(mat, nom, min, perm));
    }

    public void removeLugar(String mat) {
        this.lugares.remove(mat);
    }

    public void alteraTempo(String mat, int min) {
        Lugar l = this.lugares.getOrDefault(mat,null);
        if (l != null) {
            l.setMinutos(min);
            this.lugares.replace(mat, l);
        }
    }

    public int minutosTotalInterno() {
        return this.lugares.values().stream().mapToInt(Lugar::getMinutos).sum();
    }

    public int minutosTotalExterno() {
        int soma = 0;

        for (Lugar lu: this.lugares.values()) {
            soma += lu.getMinutos();
        }

        return soma;
    }

    public boolean existeLugar(String mat) {
        return this.lugares.containsKey(mat);
    }

    public List<String> matriculasPermMaiorInterno(int x) {
        return this.lugares.values().stream().filter(l->l.isPermanente() && l.getMinutos() > x).map(Lugar::getMatricula).collect(Collectors.toList());
    }

    public List<String> matriculaPermMaiorExterno(int x) {
        List<String> lista = new ArrayList<String>();

        for (Lugar lu: this.lugares.values()) {
            if (lu.isPermanente() && lu.getMinutos() > x)
                lista.add(lu.getMatricula());
        }

        return lista;
    }

    public Lugar getLugar(String mat) {
        return this.lugares.getOrDefault(mat, null).clone();
    }

    // setters e getters
    public void setNomeParque(String nome) {
        this.nomeParque = nome;
    }
    public void setLugares(Map<String, Lugar> mapa) {
        this.lugares = mapa.values().stream().collect(Collectors.toMap(Lugar::getMatricula, Lugar::clone));
    }
    public String getNomeParque() {
        return this.nomeParque;
    }
    public Map<String, Lugar> getLugares() {
        return this.lugares.values().stream().collect(Collectors.toMap(Lugar::getMatricula, Lugar::clone));
    }
}
