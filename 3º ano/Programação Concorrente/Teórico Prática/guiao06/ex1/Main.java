import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

class BoundedBuffer<T> {
    T buffer[];
    int iget = 0;
    int iput = 0;
    private int nelems = 0;

    Lock l = new ReentrantLock();
    Condition notEmpty = l.newCondition();
    Condition notFull = l.newCondition();

    BoundedBuffer(int N) {
        buffer = (T[]) new Object[N];
    }

    public T get() throws InterruptedException {
        l.lock();

        try {
            while (nelems == 0) notEmpty.await();
            T res = buffer[iget];
            iget = (iget + 1) % buffer.length;
            nelems--;
            notFull.signal();
            return res;
        } finally {
            l.unlock();
        }
    }

    public void put(T x) throws InterruptedException {
        l.lock();

        try {
            while (nelems == buffer.length) notFull.await();
            buffer[iput] = x;
            iput = (iput + 1) % buffer.length;
            nelems++;
            notEmpty.signal();
        } finally {
            l.unlock();
        }
    }
}

class Main {
    public static void main(String args[]) throws InterruptedException {
        BoundedBuffer<Integer> buffer = new BoundedBuffer<Integer>(5);

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
