class myThread extends Thread {
    public void run() {
        try {
            System.out.println("Hello");
            sleep(500);
            System.out.println("World!");
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}

class myRunnable implements Runnable {
    public void run() {
        System.out.println("Runnable");
    }
}

class Main {
    public static void main(String args[]) throws InterruptedException {
        Thread t1 = new myThread();
        Thread t2 = new myThread();

        t1.start();
        t1.join();
        t2.start();

        System.out.println("Main");

        Thread t3 = new Thread(new myRunnable());
        t3.start();
    }
}