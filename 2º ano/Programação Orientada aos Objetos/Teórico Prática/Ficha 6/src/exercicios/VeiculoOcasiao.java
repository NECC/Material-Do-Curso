package exercicios;

import java.util.ArrayList;

public class VeiculoOcasiao extends Veiculo {

    public VeiculoOcasiao() {
        this("n/a","n/a","n/a", 0, 0, 0, new ArrayList<Integer>(), 0, 0);

    }

    public VeiculoOcasiao(String marca, String modelo, String matricula,
                          int ano, double velociademedia, double precokm,
                          ArrayList<Integer> classificacao,
                          int kms, int kmsUltimo) {
        super.setMarca(marca);
        super.setModelo(modelo);
        super.setMatricula(matricula);
        super.setAno(ano);
        super.setVelociademedia(velociademedia);
        super.setPrecokm(precokm);
        super.setClassificacao(classificacao);
        super.setKms(kms);
        super.setKmsUltimo(kmsUltimo);
    }

    public String toString() {
        return super.toString();
    }

    public VeiculoOcasiao clone()  {
        return new VeiculoOcasiao(this.getMarca(), this.getModelo(), this.getMatricula(), this.getAno(), this.getVelociademedia(), this.getPrecokm(),
                this.getClassificacao(), this.getKms(), this.getKmsUltimo());
    }

    public double custoRealKM() {
        return this.getPrecokm() * 1.1 * 0.75;
    }
}
