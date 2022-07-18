import java.time.LocalDate;
import java.util.ArrayList;

/**
 * Feito por:
 * Joao Manuel Novais da Silva - A91671
 * Francisco Pereira Teofilo - A93741
 * Pedro António Pires Correia Leite Sequeira - A91660
 * Tiago dos Santos Silva Peixoto Carriço - A91695
 */

public class TesteEncEficiente {
    public static void main(String[] args) {
        ArrayList<LinhaEncomenda> lista = new ArrayList<LinhaEncomenda>();
        for (int i = 0; i < 5; i++) {
            lista.add(new LinhaEncomenda("Prod" + i, "Desc" + i, i*10, 1, 0.23, 0.125));
        }
        EncEficiente e1 = new EncEficiente("Pessoa", "12345", "Braga", "1", LocalDate.now(), lista);
        EncEficiente e2 = e1.clone();

        System.out.println(e1.equals(e2));

        e2.adicionaLinha(new LinhaEncomenda("Prod5", "Desc5", 100, 1, 0, 0.5));
        System.out.println(e2.toString());
        System.out.println(e1.calculaValorTotal());
        System.out.println(e2.calculaValorDesconto());
        System.out.println(e2.existeProdutoEncomenda("Prod5"));
        System.out.println(e1.existeProdutoEncomenda("Prod5"));
        e2.removeProduto("Prod5");
        System.out.println(e2.numeroTotalProdutos());
        System.out.println(e1.equals(e2));
    }
}
