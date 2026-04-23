import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;


class Exame {
    int c1,c2,c3;
    String cd1, cd2, cd3;

    Lock lock = new ReentrantLock();
    Condition notThere = lock.newCondition();

    Exame(String a, String b, String c){
        this.cd1 = a;
        this.cd2 = b;
        this.cd3 = c;

        this.c1 = 0; this.c2 = 0; this.c3 = 0;
    }


    void vota(String candidato){
        lock.lock();
        try {
            if (candidato.compareTo(cd1) == 0) { c1 += 1; }
            if (candidato.compareTo(cd2) == 0) { c2 += 1; }
            if (candidato.compareTo(cd3) == 0) { c3 += 1; }
            notThere.signalAll();
        } finally {
            lock.unlock();
        }
        //notThere.signalAll();
    }

    void espera (String a, String b, String c)  throws InterruptedException{
        lock.lock();
        try {
            if (a.compareTo(cd1) != 0) return;
            if (b.compareTo(cd2) != 0) return;
            if (c.compareTo(cd3) != 0) return;
    
            while ((c1 < c2 && c2 < c3) != true) {
                notThere.await();
            }
        } finally {
            lock.unlock();
        }
    }

    void showVotes() {
        System.out.println("Votos-----------------");
        System.out.println(cd1 + ": " + c1);
        System.out.println(cd2 + ": " + c2);
        System.out.println(cd3 + ": " + c3);
        System.out.println("----------------------");
    }
}


class Monitor {
    public static void main(String[] args) {
        Exame teste = new Exame("tiago", "sofia", "rosa");

        new Thread(() -> {
            try {
                System.out.println("Vou entrar...");
                teste.espera("tiago", "sofia", "rosa");
                System.out.println("1 - sai da espera finalmente!!!");

            } catch (Exception e) {}
        }).start();



        new Thread(() -> {
            try{
                System.out.println("Vou votar...");
                teste.showVotes();
                Thread.sleep(1000);

                teste.vota("tiago");
                teste.vota("rosa");
                teste.vota("sofia");
                teste.showVotes();

                Thread.sleep(1000);
                
                teste.vota("rosa");
                System.out.println("o 2 deve sair aqui");
                teste.vota("rosa");
                teste.showVotes();
                
                Thread.sleep(1000);
                
                teste.vota("sofia");
                System.out.println("o 1 deve sair aqui");

                teste.showVotes();

                Thread.sleep(1000);
        
        
                teste.showVotes();

            } catch (Exception e) { }
        }).start();





    }
}