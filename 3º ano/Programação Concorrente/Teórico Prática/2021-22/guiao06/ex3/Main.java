import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
import java.util.concurrent.locks.Condition;

class RWLock {
    Lock l = new ReentrantLock();
    int reading = 0;
    int writing = 0;
    Condition readLock = l.newCondition();
    Condition writeLock = l.newCondition();

    void readLock() throws InterruptedException {
        l.lock();

        try {
            while (writing > 0) writeLock.await();
            
            reading++;
        } finally {
            l.unlock();
        }
    }

    void readUnlock() {
        l.lock();

        try {
            if (reading > 0) {
                reading--;
                readLock.signalAll();
            }
        } finally {
            l.unlock();
        }
    }

    void writeLock() throws InterruptedException {
        l.lock();

        try {
            while (reading > 0) readLock.await();

            writing++;
        } finally {
            l.unlock();
        }
    }

    void writeUnlock() {
        l.lock();

        try {
            if (writing > 0) {
                writing--;
                writeLock.signalAll();
            }
        } finally {
            l.unlock();
        }
    }
}

public class Main {
    public static void main(String args[]) {
        
    }
}
