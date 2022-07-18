package exercicios;

public class VeiculoJaExisteException extends Exception {
    public VeiculoJaExisteException() {
        super();
    }

    public VeiculoJaExisteException(String msg) {
        super("Ja existe um ceiculo com a matricula " + msg);
    }
}
