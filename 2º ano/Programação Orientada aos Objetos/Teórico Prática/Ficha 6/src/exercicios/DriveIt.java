package exercicios;

import java.io.*;
import java.util.*;
import java.util.stream.Collectors;

public class DriveIt {
    private static final Map<String, Comparator<Veiculo>> comparadores = new HashMap<>();

    private Map<String, Veiculo> veiculos;
    private boolean promocao;

    public DriveIt() {
        this.veiculos = new HashMap<>();
        this.promocao = false;
    }
    public DriveIt(Map<String, Veiculo> mapa, boolean pro) {
        this.veiculos = mapa.entrySet().stream().collect(Collectors.toMap(Map.Entry::getKey, e-> e.getValue().clone()));
        this.promocao = pro;
    }

    public boolean existeVeiculo(String mat) {
        return this.veiculos.containsKey(mat);
    }

    public int quantos() {
        return this.veiculos.size();
    }

    public int quantos(String marca) {
        return (int) this.veiculos.values().stream().filter(a->a.getMarca().equals(marca)).count();
    }

    public Veiculo getVeiculo(String mat) throws VeiculoNaoExisteException {
        Veiculo v = this.veiculos.get(mat);
        if (v == null) throw new VeiculoNaoExisteException(mat);
        return v.clone();
    }

    public void adiciona(Veiculo v) throws VeiculoJaExisteException {
        if (this.veiculos.containsKey(v.getMatricula())) {
            throw new VeiculoJaExisteException(v.getMatricula());
        } else this.veiculos.put(v.getMarca(), v.clone());
    }

    public List<Veiculo> getVeiculos() {
        return this.veiculos.values().stream().map(Veiculo::clone).collect(Collectors.toList());
    }

    public void adiciona(Set<Veiculo> vs) throws VeiculoJaExisteException {
        for (Veiculo v : vs) {
            adiciona(v);
        }
    }

    public void registarAluguer(String mat, int numKms) throws VeiculoNaoExisteException {
        Veiculo v = this.veiculos.get(mat);
        if (v == null) throw new VeiculoNaoExisteException(mat);
        else  v.addViagem(numKms);
    }

    public void ClassificarVeiculo(String mat, int clas) throws VeiculoNaoExisteException {
        Veiculo v = this.veiculos.get(mat);
        if (v == null) throw new VeiculoNaoExisteException(mat);
        else v.addClassificacao(clas);
    }

    public double custoRealKm(String mat)  throws VeiculoNaoExisteException {
        Veiculo v = this.veiculos.get(mat);
        if (v == null) throw new VeiculoNaoExisteException(mat);
        else return v.custoRealKM();
    }

    public int quantosT(String tipo) {
        return (int) this.veiculos.values().stream().filter(a->a.getClass().getSimpleName().equals(tipo)).count();
    }

    public List<Veiculo> veiculosOrdenadosCusto() {
        return this.veiculos.values().stream().sorted((a,b)->{
            double pA, pB;
            pA = a.custoRealKM();
            pB = b.custoRealKM();

            return (int) (pB-pA);
        }).map(Veiculo::clone).collect(Collectors.toList());
    }

    public Veiculo veiculoMaisBarato() {
        List<Veiculo> vs = this.veiculosOrdenadosCusto();
        return vs.get(vs.size()-1);
    }

    public Veiculo veiculoMenosUtilizado() {
        return this.veiculos.values().stream().sorted(Comparator.comparingInt(Veiculo::getKms))
                .map(Veiculo::clone).collect(Collectors.toList()).stream().findFirst().get();
    }

    public void alteraPromocao(boolean estado) {
        this.promocao = estado;
    }
    /*
    public Set<Veiculo> ordenarVeiculos() {
        return this.veiculos.values().stream().sorted().collect(Collectors.toCollection(TreeSet::new));
    }
    */
    public List<Veiculo> ordenarVeiculos() {
        return this.veiculos.values().stream().sorted().collect(Collectors.toList());
    }

    public Set<Veiculo> ordenarVeiculos(Comparator<Veiculo> comp) {
        return this.veiculos.values().stream().sorted(comp).collect(Collectors.toCollection(TreeSet::new));

    }

    public void adicionarComparador(String crit, Comparator<Veiculo> comp) {
        if (!comparadores.containsKey(crit)) comparadores.put(crit, comp);
    }

    public void removerComparador(String criterio) {
        comparadores.remove(criterio);
    }

    public Iterator<Veiculo> ordenarVeiculo(String criterio) {
        if (!comparadores.containsKey(criterio)) return null;
        return this.veiculos.values().stream().sorted(comparadores.get(criterio)).iterator();
    }

    public List<BonificaKms> daoPontos() {
        return this.veiculos.values().stream().filter(a->a instanceof BonificaKms)
                .map(a->(BonificaKms) a.clone()).collect(Collectors.toList());
    }

    // Ficheiros
    public void gravar(String file) throws IOException {
        FileOutputStream fos = new FileOutputStream(file);
        ObjectOutputStream oos = new ObjectOutputStream(fos);
        oos.writeObject(this);
        oos.close();
        fos.close();
    }

    public void ler(String file) throws IOException, ClassNotFoundException {
        FileInputStream fis = new FileInputStream(file);
        ObjectInputStream ois = new ObjectInputStream(fis);
        DriveIt lido = (DriveIt) ois.readObject();
        this.veiculos = lido.veiculos.values().stream().collect(Collectors.toMap(Veiculo::getMatricula, a->a));
        this.promocao = lido.promocao;
        ois.close();
        fis.close();
    }
}