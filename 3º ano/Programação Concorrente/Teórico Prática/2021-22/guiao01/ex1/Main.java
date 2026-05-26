class myThread extends Thread {
    public int I;

    public void run() {
        for (int i = 1; i < I; i++) {
            System.out.println(i);
        }
    }
}

public class Main {
    public static void main(String args[]) {
        try {
            final int N = Integer.parseInt(args[0]);
            final int I = Integer.parseInt(args[1]);

            for (int i = 0; i < N; i++) {
                myThread t = new myThread();
                t.I = I;

                t.start();
                t.join();
            }

            System.out.println("Done");
        } catch (InterruptedException e) {
            e.printStackTrace();
        }


    }
}
