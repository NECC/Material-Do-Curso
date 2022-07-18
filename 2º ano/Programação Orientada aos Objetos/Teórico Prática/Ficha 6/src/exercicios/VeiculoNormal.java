package exercicios;

import java.util.ArrayList;

public class VeiculoNormal extends Veiculo {
    public VeiculoNormal() {
        this("n/a","n/a","n/a", 0, 0, 0, new ArrayList<Integer>(), 0, 0);
    }

    public VeiculoNormal(String marca, String modelo, String matricula,
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

    public VeiculoNormal(VeiculoNormal v) {
        this(v.getMarca(), v.getModelo(), v.getMatricula(), v.getAno(), v.getVelociademedia(), v.getPrecokm(),
                v.getClassificacao(),v.getKms(),v.getKmsUltimo());
    }

    public VeiculoNormal clone() {
        return new VeiculoNormal(this);
    }

    public double custoRealKM() {
        return this.getPrecokm()*1.1;
    }
}
