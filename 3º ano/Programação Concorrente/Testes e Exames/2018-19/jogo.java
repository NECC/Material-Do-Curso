import java.util.Random;

interface Jogo {
    Partida participa() throws InterruptedException ;
}

interface Partida {
    String adivinha(int n);
}

class JogoImpl implements Jogo {
    PartidaImpl p = new PartidaImpl();
    int jogadores = 0;

    public synchronized Partida participa() throws InterruptedException {
        PartidaImpl ps = p;
        jogadores++;
        if (jogadores == 4) {
            notifyAll();
            jogadores = 0;
            ps.start();
            p = new PartidaImpl();
        } else {
            while (p == ps) wait();
        }

        return ps;
    }
}

class PartidaImpl implements Partida {
    int tentativas = 0;
    boolean ganhou = false;
    boolean timeout = false;
    int numero;

    public void start() throw InterruptedException {
        numero = new Random().nextInt(100);
        new Thread(() -> {
            Thread.sleep(60000);
            timeout();
        }).start();
    }

    synchronized void timeout() {
        timeout = true;
    }

    public synchronized String adivinha(int n) {
        if (ganhou) return "PERDEU";
        else if (tentativas >= 100) return "TENTATIVAS";
        else if (timeout) return "TEMPO";
        else {
            tentativas++;
            if (n > numero) return "MENOR";
            else if (n < numero) return "MAIOR";
            else {
                ganhou = true;
                return "GANHOU";
            }
        }

        return "";
    }
}