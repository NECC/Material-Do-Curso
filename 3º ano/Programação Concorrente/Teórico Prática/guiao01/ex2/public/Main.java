public class Main {
    public static void main(String args[]) {
        final int N = Integer.parseInt(args[0]);
        final int I = Integer.parseInt(args[1]);
        Counter counter = new Counter();

        for (int i = 0; i < N; i++) {
            myThread t = new myThread(counter, I);

            t.start();
            // t.join();
        }

        counter.printX();
        System.out.println("Done");
    }
} 

class Counter {
    public int x;

    public Counter() {
        this.x = 0;
    }

    public void printX() {
        System.out.println(x);
    }
}

class myThread extends Thread {
    private Counter c;
    private int I;

    public myThread(Counter counter, int i) {
        this.c = counter;
        this.I = i;
    }

    public void run() {
        for (int i = 1; i <= I; i++) {
            this.c.x++;
            this.c.printX();
        }
    }
}