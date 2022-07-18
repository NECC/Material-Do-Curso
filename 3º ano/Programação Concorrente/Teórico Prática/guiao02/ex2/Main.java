class NotEnoughFunds extends Exception {}
class InvalidAccount extends Exception {}

class Bank {
    private static class Account {
        private int balance;
        public int balance() { return balance; }
        public void deposit(int val) { balance += val; }
        public void withdraw(int val) throws NotEnoughFunds {
            if (balance < val) throw new NotEnoughFunds();
            balance -= val;
        }
    }
    private Account[] accounts;
    private int N;

    Bank(int n) {
        N = n;
        accounts = new Account[n];
        for (int i = 0; i < n; i++) accounts[i] = new Account();
    }

    synchronized void deposit(int id, int val) throws InvalidAccount {
        if (id < 0 || id >= N) throw new InvalidAccount();
        accounts[id].deposit(val);
    }

    synchronized void withdraw(int id, int val) throws InvalidAccount, NotEnoughFunds {
        if (id < 0 || id >= N) throw new InvalidAccount();
        accounts[id].withdraw(val);
    }

    synchronized int totalBalance(int acc[]) throws InvalidAccount {
        int total = 0;
        for (int i = 0; i < N; i++) {
            if (acc[i] < 0 || acc[i] >= N) throw new InvalidAccount();
            total += accounts[acc[i]].balance();
        }
        return total;
    }

    synchronized int accountBalance(int id) throws InvalidAccount {
        if (id < 0 || id >= N) throw new InvalidAccount();
        return accounts[id].balance();
    }
}

class Depositor extends Thread {
    private Bank b;
    private int iterator;
    
    Depositor(Bank bank, int iterator) {
        b = bank;
        this.iterator = iterator;
    }

    public void run() {
        try {
            for (int i = 0; i < iterator; i++) {
                b.deposit(i, 100*i);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

class Main {
    public static void main(String args[]) throws InterruptedException, InvalidAccount {
        final int NC = Integer.parseInt(args[0]); // NC = int(args[0])
        final int N = Integer.parseInt(args[1]);
        final int I = Integer.parseInt(args[2]);

        Bank b = new Bank(NC);
        Thread[] a = new Depositor[N];

        for (int i = 0; i < N; i++) { a[i] = new Depositor(b, I); }
        for (int i = 0; i < N; i++) { a[i].start(); }
        for (int i = 0; i < N; i++) { a[i].join(); }

        for (int i = 0; i < N; i++) System.out.println(b.accountBalance(i));
    }
}