import java.util.HashMap;
import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

class Warehouse {
    Lock l = new ReentrantLock();

    class Record {
        public int quant = 0;
        public Condition cond = l.newCondition();

        void add(int x) {
            quant += x;
            cond.signalAll();
        }

        void remove() throws InterruptedException {
            while (quant < 1) cond.await();

            quant--;
        }
    }

    HashMap<String, Record> stock = new HashMap<>();

    void supply(String item, int quantity) {
        l.lock();

        try {
            if (!stock.containsKey(item)) {
                Record temp = new Record();
                stock.put(item, temp);
            }
            stock.get(item).add(quantity);
        } finally {
            l.unlock();
        }
    }

    void consume(String[] items) throws InterruptedException {
        for (String item : items) {
            l.lock();
            try {
                if (!stock.containsKey(item)) {
                    Record temp = new Record();
                    stock.put(item, temp);
                }
                
                stock.get(item).remove();
            } finally {
                l.unlock();
            }
        }
    }
}

public class Main {
    public static void main(String args[]) {
        Warehouse w = new Warehouse();

        new Thread(() -> {
            try {
                System.out.println("Consuming martelos");
                String items[] = {"martelo", "martelo"};
                w.consume(items);
                System.out.println("Consumed 2 martelos");
            } catch (Exception e) {}
        }).start();

        new Thread(() -> {
            try {
                System.out.println("Consuming pcs");
                String items[] = {"pc", "pc", "pc", "pc", "pc"};
                w.consume(items);
                System.out.println("Consumed 5 pcs");
            } catch (Exception e) {}
        }).start();

        new Thread(() -> {
            try {
                System.out.println("Supplying martelos");
                w.supply("martelo", 10);
                System.out.println("Supplied 10 martelos");
            } catch (Exception e) {}
        }).start();

        new Thread(() -> {
            try {
                for (int i = 0; i < 5; i++) {
                    Thread.sleep(500);
                    System.out.println("Supplying pcs");
                    w.supply("pc", 1);
                    System.out.println("Supplied 1 pcs");
                }
            } catch (Exception e) {}
        }).start();
    }
}
