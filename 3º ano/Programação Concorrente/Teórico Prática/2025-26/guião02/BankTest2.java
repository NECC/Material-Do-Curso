import java.util.Random;

public class BankTest2 {

    private static class Mover implements Runnable {
        private Bank b;
        private int accs;
        private int iters;

        public Mover(Bank b, int accs, int iters) {
            this.b = b;
            this.accs = accs;
            this.iters = iters;
        }

        public void run() {
            Random rand = new Random();
            for (int m = 0; m < iters; m++) {
                int from = rand.nextInt(accs);
                int to = rand.nextInt(accs);
                b.transfer(from, to, 1);
            }
        }
    }

    private static class Observer implements Runnable {
        private Bank b;
        private int expectedBalance;
        private int iters;

        public Observer(Bank b, int expectedBalance, int iters) {
            this.b = b;
            this.expectedBalance = expectedBalance;
            this.iters = iters;
        }

        public void run() {
            for (int i = 0; i < iters; i++) {
                int balance = b.totalBalance();
                if (balance != this.expectedBalance) {
                    System.out.println("Unexpected balance: " + balance);
                }
            }
        }
    }

    public static void main(String[] args) throws InterruptedException {
        int ACCS = 10;
        int ITERS = 100000;

        Bank b = new Bank(ACCS);
        for (int i = 0; i < ACCS; i++)
            b.deposit(i, 1000);
        int balance = b.totalBalance();
        System.out.println(balance);

        Thread t1 = new Thread(new Mover(b, ACCS, ITERS)); 
        Thread t2 = new Thread(new Mover(b, ACCS, ITERS));
        Thread t3 = new Thread(new Observer(b, balance, ITERS));
        t1.start();
        t2.start();
        t3.start();
        t1.join();
        t2.join();
        t3.join();
        System.out.println(b.totalBalance());
    }
}

