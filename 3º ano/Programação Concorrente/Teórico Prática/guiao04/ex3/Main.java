import java.util.concurrent.Semaphore;

class Barreira {
    private final int N;
    private int counter = 0;
    Semaphore mut = new Semaphore(1);
    Semaphore sem = new Semaphore(0);
    
    Barreira(int N) {
        this.N = N;
    }

    public void await() throws InterruptedException {
        mut.acquire();
        counter++;
        int v = counter;
        mut.release();

        if (v == N) {
            for (int i = 0; i < N - 1; i++) sem.release();
        } else {
            sem.acquire();
        }
    }
}

public class Main {
    public static void main(String args[]) {
        try {
            int N = 5;
            Barreira b = new Barreira(N);

            for (int i = 0; i < N; i++) {
                new Thread(() -> {
                    try {
                        System.out.println("Await");
                        b.await();
                        System.out.println("Released");
                    } catch (Exception e) {}
                }).start();
                Thread.sleep(200);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}