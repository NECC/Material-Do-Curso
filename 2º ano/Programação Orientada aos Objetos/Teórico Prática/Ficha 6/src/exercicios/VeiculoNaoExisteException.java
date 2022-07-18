package exercicios;

public class VeiculoNaoExisteException extends Exception{
    public VeiculoNaoExisteException() {
        super();
    }

    public VeiculoNaoExisteException(String msg) {
        super("Nao existe Veiculo com matricula " + msg);
    }
}
