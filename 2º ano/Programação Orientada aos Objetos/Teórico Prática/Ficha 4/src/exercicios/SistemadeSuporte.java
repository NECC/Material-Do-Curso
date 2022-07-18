package exercicios;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.DoubleStream;

public class SistemadeSuporte {
    ArrayList<PedidodeSuporte> pedidos;

    public SistemadeSuporte(ArrayList<PedidodeSuporte> ps) {
        this.pedidos = new ArrayList<PedidodeSuporte>();
        for (PedidodeSuporte elem : ps)
            this.pedidos.add(elem.clone());
    }

    public SistemadeSuporte() {
        this(new ArrayList<PedidodeSuporte>());
    }

    public SistemadeSuporte(SistemadeSuporte s) {
        this(s.pedidos);
    }

    public boolean equals(Object o) {
        if (this == o) return true;

        if (o == null || this.getClass() != o.getClass()) return false;

        SistemadeSuporte s = (SistemadeSuporte) o;
        boolean same = true;
        if (this.pedidos.size() != s.pedidos.size()) return false;

        for (int i = 0; same && i < this.pedidos.size(); i++) {
            same = this.pedidos.get(i).equals(s.pedidos.get(i));
        }

        return same;
    }

    public String toString() {
        StringBuilder sb = new StringBuilder("Pedidos: ");

        for (PedidodeSuporte elem : this.pedidos) {
            sb.append(elem.toString());
            sb.append("\n");
        }
        return sb.toString();
    }

    public SistemadeSuporte clone() {
        return new SistemadeSuporte(this);
    }

    public void inserePedido(PedidodeSuporte pedido) {
        this.pedidos.add(pedido.clone());
    }

    public PedidodeSuporte procuraPedido(String user, LocalDateTime data) {
        PedidodeSuporte p = this.pedidos.stream().filter(a->a.getNome().equals(user) && a.getDate().equals(data)).findFirst().orElse(null);
        if (p != null) p = p.clone();
        return p;
    }

    public void resolvePedido(PedidodeSuporte pedido, String tecnico, String info) {
        boolean enc = false;
        int i = 0;
        for (i = 0; !enc && i < this.pedidos.size(); i++) {
            enc = this.pedidos.get(i).equals(pedido);
        }
        if (enc) i--;
        else {
            this.pedidos.add(pedido);
            i = this.pedidos.size() - 1;
        }
        pedido.setTratado(tecnico);
        pedido.setResposta(info);
        pedido.setDataTratado(LocalDateTime.now());
        this.pedidos.set(i, pedido);
    }

    public List<PedidodeSuporte> resolvidos() {
        return this.pedidos.stream().filter(a->a.getTratado().equals("")).collect(Collectors.toList());
    }

    public String colaboradorTop() {
        ArrayList<PedidodeSuporte> lista = new ArrayList<>(this.pedidos);
        int max = -1;
        String colab = "";
        int resolvidos;
        for (PedidodeSuporte ped : lista) {
            resolvidos = (int) lista.stream().filter(a->a.getTratado().equals(ped.getTratado())).count();
            if (resolvidos > max) {
                max = resolvidos;
                colab = ped.getTratado();
            }
        }
        return colab;
    }

    public List<PedidodeSuporte> resolvidos(LocalDateTime inicio, LocalDateTime fim) {
        return this.pedidos.stream().filter(a->a.getDate().isAfter(inicio) && a.getDate().isBefore(fim) && !a.getTratado().equals("")).collect(Collectors.toList());
    }

    public double tempoMedioResolucao() {
        DoubleStream lista = this.pedidos.stream().filter(a->!a.getTratado().equals("")).mapToDouble(a-> ChronoUnit.MINUTES.between(a.getDate(), a.getDataTratado()));
        return lista.sum() / lista.count();
    }

    public double tempoMedioResolucao(LocalDateTime inicio, LocalDateTime fim) {
        DoubleStream lista = this.pedidos.stream().filter(a->a.getDate().isAfter(inicio) && a.getDate().isBefore(fim) && !a.getTratado().equals("")).mapToDouble(a-> ChronoUnit.MINUTES.between(a.getDate(), a.getDataTratado()));
        return lista.sum() / lista.count();
    }

    public PedidodeSuporte pedidoMaisLongo() {
        ArrayList<PedidodeSuporte> lista = new ArrayList<>(this.pedidos).stream()
                .filter(a -> !a.getTratado().equals(""))
                .sorted(Comparator.comparing(a -> ChronoUnit.MINUTES.between(a.getDate(), a.getDataTratado())))
                .collect(Collectors.toCollection(ArrayList::new));

        Collections.reverse(lista);
        if (lista.isEmpty()) return null;

        return lista.stream().findFirst().orElse(null).clone();
    }

    public PedidodeSuporte pedidoMaisLongo(LocalDateTime inicio, LocalDateTime fim) {
        ArrayList<PedidodeSuporte> lista = new ArrayList<>(this.pedidos).stream()
                .filter(a -> !a.getTratado().equals("") && a.getDataTratado().isAfter(inicio) && a.getDataTratado().isBefore(fim))
                .sorted(Comparator.comparing(a -> ChronoUnit.MINUTES.between(a.getDate(), a.getDataTratado())))
                .collect(Collectors.toCollection(ArrayList::new));

        Collections.reverse(lista);
        if (lista.isEmpty()) return null;

        return lista.stream().findFirst().orElse(null).clone();
    }

    public PedidodeSuporte pedidoMaisCurto() {
        ArrayList<PedidodeSuporte> lista = new ArrayList<>(this.pedidos).stream()
                .filter(a -> !a.getTratado().equals(""))
                .sorted(Comparator.comparing(a -> ChronoUnit.MINUTES.between(a.getDate(), a.getDataTratado())))
                .collect(Collectors.toCollection(ArrayList::new));

        if (lista.isEmpty()) return null;

        return lista.stream().findFirst().orElse(null).clone();
    }

    public PedidodeSuporte pedidoMaisCurto(LocalDateTime inicio, LocalDateTime fim) {
        ArrayList<PedidodeSuporte> lista = new ArrayList<>(this.pedidos).stream()
                .filter(a -> !a.getTratado().equals("") && a.getDataTratado().isAfter(inicio) && a.getDataTratado().isBefore(fim))
                .sorted(Comparator.comparing(a -> ChronoUnit.MINUTES.between(a.getDate(), a.getDataTratado())))
                .collect(Collectors.toCollection(ArrayList::new));

        if (lista.isEmpty()) return null;

        return lista.stream().findFirst().orElse(null).clone();
    }

    // setters e getters
}
