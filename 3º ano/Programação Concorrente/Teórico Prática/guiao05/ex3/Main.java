class Barreira {
    private final int N;
    private int counter = 0;
    private int round = 0;


    Barreira(int N) {
        this.N = N;
    }

    public synchronized void await() throws InterruptedException {
        counter++;

        int r = round;

        if (counter == N) {
            notifyAll();
            System.out.println("notifyAll");

            counter = 0;
            round++;

            Thread.sleep(1000);
        }

        while (r == round)
            wait();
        System.out.println("Wait over");
    }
}

public class Main {
    public static void main(String args[]) {
        try {
            int N = 5;
            Barreira b = new Barreira(N);

            for (int i = 0; i < N+1; i++) {
                final int x = i;
                new Thread(() -> {
                    try {
                        System.out.println("Await " + (x+1));
                        b.await();
                        System.out.println("Released " + (x+1));
                    } catch (Exception e) {}
                }).start();
                Thread.sleep(200);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}