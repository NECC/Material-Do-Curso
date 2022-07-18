package ex4;

import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;

public class GestaoEncomendas implements Comparable<GestaoEncomendas>{
    private Map<String, Encomenda> encomendas;

    public GestaoEncomendas() {
        encomendas = null;
    }

    public GestaoEncomendas(Map<String, Encomenda> encs) {
        this.encomendas = encs.values().stream().collect(Collectors.toMap(Encomenda::getNumero, Encomenda::clone));
    }

    public GestaoEncomendas(GestaoEncomendas g) {
        this(g.encomendas);
    }

    public GestaoEncomendas clone() {
        return new GestaoEncomendas(this);
    }

    public boolean equals(Object o) {
        if (this == o) return true;

        if (o == null || this.getClass() != o.getClass()) return false;

        GestaoEncomendas g = (GestaoEncomendas) o;
        return this.encomendas.equals(g.encomendas);
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();

        sb.append("Encomendas:\n");
        this.encomendas.values().forEach(a->sb.append(a.toString()));

        return sb.toString();
    }

    public int compareTo(GestaoEncomendas gestaoEncomendas) {
        return this.encomendas.size() - gestaoEncomendas.encomendas.size();
    }

    public Set<String> todosCodigosEnc() {
        return this.encomendas.keySet();
    }

    public void addEncomenda(Encomenda e) {
        this.encomendas.put(e.getNumero(), e.clone());
    }

    public Encomenda getEncomenda(String numero) {
        return this.encomendas.getOrDefault(numero,null).clone();
    }

    public void removeEncomenda(String numero) {
        this.encomendas.remove(numero);
    }

    public String encomendaComMaisProdutos() {
        if (this.encomendas.isEmpty()) return null;

        return this.encomendas.values().stream().min((a, b) -> b.numeroTotalProdutos() - a.numeroTotalProdutos()).get().getNumero();
    }

    public Set<String> encomendasComProduto(String codProd) {
        return this.encomendas.values().stream().filter(a->a.existeProdutoEncomenda(codProd)).map(Encomenda::getNumero).collect(Collectors.toSet());
    }

    public Set<String> encomendasAposData(LocalDate data) {
        return this.encomendas.values().stream().filter(a->a.getData().isAfter(data)).map(Encomenda::getNumero).collect(Collectors.toSet());
    }

    public Set<Encomenda> encomendasValorDecrescente() {
        Comparator<Encomenda> c = new Comparator<Encomenda>() {
            public int compare(Encomenda e1, Encomenda e2) {
                double a = e2.calculaValorTotal()-e1.calculaValorTotal();
                if (a == 0) return 0;
                if (a >= 0) return 1;
                else return -1;
            }
        };
        return this.encomendas.values().stream().sorted(c).collect(Collectors.toCollection(TreeSet::new));
    }

    // Acho que isto funciona mas nao testei
    public Map<String, List<String>> encomendasDeProduto() {
        Map<String, List<String>> mapa = new HashMap<>();

        this.encomendas.values().forEach(elem->{
            elem.getEncomendas().forEach(a->{
                List<String> lista = mapa.get(a.getReferencia());
                if (lista == null) {
                    lista = new ArrayList<>();
                }
                lista.add(elem.getNumero());
                mapa.put(a.getReferencia(), lista);
            });
        });

        return mapa;
    }

    // setters e getters
    public void setEncomendas(Map<String, Encomenda> encs) {
        this.encomendas = encs.values().stream().collect(Collectors.toMap(Encomenda::getNumero, Encomenda::clone));
    }
    public Map<String, Encomenda> getEncomendas() {
        return this.encomendas.values().stream().collect(Collectors.toMap(Encomenda::getNumero, Encomenda::clone));
    }
}
