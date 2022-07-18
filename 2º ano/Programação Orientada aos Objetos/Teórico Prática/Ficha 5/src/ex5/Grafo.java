package ex5;

import java.net.Inet4Address;
import java.util.*;
import java.util.stream.Collectors;

public class Grafo {
    private Map<Integer, Set<Integer>> adjacencias;

    public Grafo() {
        this.adjacencias = new HashMap<>();
    }

    public Grafo(Map<Integer, Set<Integer>> adj) {
        this.adjacencias = adj.entrySet().stream().collect(Collectors.toMap(Map.Entry::getKey, a->new HashSet<>(a.getValue())));
    }

    public void addArco(Integer vOri, Integer vDest) {
        Set<Integer> set = this.adjacencias.get(vOri);
        if (set == null) {
            set = new HashSet<>();
        }
        set.add(vDest);
        this.adjacencias.put(vOri, set);
        if (!this.adjacencias.containsKey(vDest)) {
            set = new HashSet<>();
            this.adjacencias.put(vDest, set);
        }
    }

    public boolean isSink(Integer v) {
        if (!this.adjacencias.containsKey(v)) return true;
        return this.adjacencias.get(v).isEmpty();
    }

    public boolean isSource(Integer v) {
        return this.adjacencias.values().stream().noneMatch(a->a.contains(v));
    }

    public int size() {
        return this.adjacencias.size() + this.adjacencias.values().stream().mapToInt(Set::size).sum();
    }

    // Breadth-first Search
    // Nao testei
    public boolean haCaminho(Integer vOri, Integer vDest) {
        Queue<Integer> queue = new LinkedList<>();
        queue.add(vOri);
        Set<Integer> visitados = new HashSet<>();
        visitados.add(vOri);

        while (!queue.isEmpty()) {
            Integer vertice = queue.remove();
            if (vertice.equals(vDest)) return true;

            for (Integer prox : this.adjacencias.get(vertice)) {
                if (!visitados.contains(prox)) {
                    queue.add(prox);
                    visitados.add(prox);
                }
            }
        }

        return false;
    }

    // Tambem nao testei
    public List<String> getCaminho(Integer vOri, Integer vDest) {
        Queue<Integer> queue = new LinkedList<>();
        queue.add(vOri);
        Map<Integer, Integer> pais = new HashMap<>();

        while (!queue.isEmpty()) {
            Integer vertice = queue.remove();
            if (vertice.equals(vDest)) break;

            for (Integer prox : this.adjacencias.get(vertice)) {
                if (!pais.containsKey(prox)) {
                    pais.put(prox, vertice);
                    queue.add(prox);
                }
            }
        }

        //Construir Lista
        List<String> lista = null;
        if (pais.containsKey(vDest)) {
            lista = new ArrayList<>();

            for (Integer v = vDest; !v.equals(vOri); v = pais.get(v)) {
                String sb = pais.get(v) +
                        "->" +
                        v;
                lista.add(sb);
            }

        }
        return lista;
    }

    // wtf is Map.Entry, literalmente nao da para inicializar
    public Set<Map.Entry<Integer, Integer>> fanOut (Integer v) {
        if (!this.adjacencias.containsKey(v)) return null;

        Set<Map.Entry<Integer, Integer>> set = new HashSet<>();

        this.adjacencias.get(v).forEach(a->{
            Map<Integer, Integer> mapa = new HashMap<>();
            mapa.put(v,a);
            set.add(mapa.entrySet().stream().findAny().get());
        });

        return set;
    }

    public boolean subGrafo(Grafo g) {
        if (!g.adjacencias.keySet().containsAll(this.adjacencias.keySet())) return false;

        for (Integer v : this.adjacencias.keySet()) {
            if (!g.adjacencias.get(v).containsAll(this.adjacencias.get(v))) return false;
        }

        return true;
    }
}
