import java.util.HashMap;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
import java.util.ArrayList;
import java.util.Collections;

class NotEnoughFunds extends Exception {}
class InvalidAccount extends Exception {}

class Bank {
    private static class Account {
        private int balance;
        Lock lock = new ReentrantLock();

        Account(int bal) {
            this.balance = bal;
        }

        int balance() { return balance; }
        void deposit(int val) { balance += val; }
        void withdraw(int val) throws NotEnoughFunds {
            if (balance < val) throw new NotEnoughFunds();
            balance -= val;
        }
    }

    private HashMap<Integer ,Account> accounts = new HashMap<Integer, Account>();
    private Lock lock = new ReentrantLock();
    private int number_account = 0;

    int createAccount(int initialBalance) {
        this.lock.lock();

        try {
            this.accounts.put(this.number_account++, new Account(initialBalance));
        } finally {
            this.lock.unlock();
        }

        return this.number_account - 1;
    }

    int closeAccount(int id) throws InvalidAccount {
        Account a;
        this.lock.lock();
        
        try {
            a = this.accounts.get(id);

            if (a == null) throw new InvalidAccount();

            this.accounts.remove(id);

            a.lock.lock();
        } finally {
            this.lock.unlock();
        }

        try {
            return a.balance();
        } finally {
            a.lock.unlock();
        }
    }

    void deposit(int id, int val) throws InvalidAccount {
        Account a;

        this.lock.lock();

        try {
            a = this.accounts.get(id);

            if (a == null) throw new InvalidAccount();

            a.lock.lock();
        } finally {
            this.lock.unlock();
        }

        try {
            a.deposit(val);
        } finally {
            a.lock.unlock();
        }
    }

    void withdraw(int id, int val) throws InvalidAccount, NotEnoughFunds {
        Account a;

        this.lock.lock();
        
        try {
            a = this.accounts.get(id);

            if (a == null) throw new InvalidAccount();

            a.lock.lock();
        } finally {
            this.lock.unlock();
        }

        try {
            a.withdraw(val);
        } finally {
            a.lock.unlock();
        }
    }

    void transfer(int from, int to, int amount) throws InvalidAccount, NotEnoughFunds {
        Account o1, o2, cfrom, cto;

        this.lock.lock();

        try {
            o1 = this.accounts.get(Math.min(from, to));
            o2 = this.accounts.get(Math.max(from, to));
            cfrom = this.accounts.get(from);
            cto = this.accounts.get(to);

            if (o1 == null || o2 == null || cfrom == null || cto == null) throw new InvalidAccount();

            o1.lock.lock();
            o2.lock.lock();
        } finally {
            this.lock.unlock();
        }

        try {
            cfrom.withdraw(amount);
            cto.deposit(amount);
        } finally {
            o1.lock.unlock();
            o2.lock.unlock();
        }
    }

    int totalBalance(int accs[]) throws InvalidAccount {
        ArrayList<Integer> account_list = new ArrayList<Integer>();

        for (int i : accs) {
            account_list.add(i);
        }

        Collections.sort(account_list);

        Account a;
        int total = 0;

        for (int i : account_list) {
            this.lock.lock();
            try {
                a = this.accounts.get(i);

                if (a == null) throw new InvalidAccount();
                a.lock.lock();
            } finally {
                this.lock.unlock();
            }

            try {
                total += a.balance();
            } finally {
                a.lock.unlock();
            }
        }

        return total;
    }

    int accountBalance(int id) throws InvalidAccount {
        this.lock.lock();
        Account a;

        try {
            a = this.accounts.get(id);

            if (a == null) throw new InvalidAccount();

            a.lock.lock();
        } finally {
            this.lock.unlock();
        }

        try {
            return a.balance();
        } finally {
            a.lock.unlock();
        }
    }
}

public class Main {
    public static void main(String args[]) {
            try {
                int accounts[] = new int[10];
                int n = 10;
                Bank b = new Bank();

                for (int i = 0; i < n; i++) accounts[i] = b.createAccount(i+1);
                for (int i = 0; i < n; i++) b.deposit(accounts[i], 100*(i+1));

                printAccountBalances(accounts, b, n);

                System.out.println("Closed account 5 with $" + b.closeAccount(5) + ".");

                b.transfer(9, 0, 300);
                int newList[] = {0,1,2,3,4,6,7,8,9};
                System.out.println(b.totalBalance(newList));
            } catch (Exception e) {
                e.printStackTrace();
            }

    }

    public static void printAccountBalances(int accounts[], Bank b, int n) throws InvalidAccount, NotEnoughFunds {
        for (int i = 0; i < n; i++) {
            try {
                System.out.println("Account " + i + ": " + b.accountBalance(accounts[i]));
            } catch (InvalidAccount ia) {
                System.out.println("Account "+ i + " does not exist.");
            }
        }
    }
}
