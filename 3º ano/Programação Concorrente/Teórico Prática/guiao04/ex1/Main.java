import java.util.concurrent.Semaphore;

class BoundedBuffer<T> {
    T buffer[];
    int iget = 0;
    int iput = 0;

    Semaphore items;
    Semaphore slots;
    Semaphore mutcons = new Semaphore(1);
    Semaphore mutprod = new Semaphore(1);

    BoundedBuffer(int N) {
        buffer = (T[]) new Object[N];
        items = new Semaphore(0);
        slots = new Semaphore(N);
    }
    
    public T get() throws InterruptedException {
        items.acquire();
        mutcons.acquire();
        T res = buffer[iget];
        iget = (iget + 1) % buffer.length;
        mutcons.release();
        slots.release();
        return res;
    }

    public void put(T x) throws InterruptedException {
        slots.acquire();
        mutprod.acquire();
        buffer[iput] = x;
        iput = (iput + 1) % buffer.length;
        mutprod.release();
        items.release();
    }
}

class Main {
    public static void main(String args[]) throws InterruptedException {
        BoundedBuffer<Integer> buffer = new BoundedBuffer(5);

        Thread produtor = new Thread(() -> {
            try {
                int i = 0;
                while (true) {
                    System.out.println("Putting " + i);
                    buffer.put(i++);
                    Thread.sleep(200);
                }
            } catch (Exception e) {}
        });

        Thread consumidor = new Thread(() -> {
            try {
                while (true) {
                    System.out.println("Getting");
                    System.out.println("x = " + buffer.get());
                    Thread.sleep(200);
                }
            } catch (Exception e) {}
        });

        consumidor.start();
        produtor.start();
    }
}