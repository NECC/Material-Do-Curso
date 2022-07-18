import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

import javax.management.openmbean.OpenMBeanConstructorInfo;


class Ponte {

    int ocupacao=0;
    Lock lock = new ReentrantLock();
    Condition canReturn = lock.newCondition();
    Condition canGo = lock.newCondition();

    
    void inicioTravessiaIda() throws InterruptedException {
        lock.lock();
        try{
            if (ocupacao == 10) {
                System.out.println("Ponte cheia");
                wait(); 
            }
            ocupacao +=1;
            Thread.sleep(5000);
            fimTravessia();
        } finally {
            lock.unlock();
        }


    }

    void inicioTravessiaVolta() throws InterruptedException{
        lock.lock();
        try{
            if (ocupacao == 10) {
                System.out.println("Ponte cheia");
                wait(); 
            }
            ocupacao +=1;
            Thread.sleep(5000);
            fimTravessia();
        } finally {
            lock.unlock();
        }
    

    }

    void fimTravessia() throws InterruptedException{
        lock.lock();
        try {
            ocupacao-=1;
            System.out.println("Pode entrar um");           
            canReturn.signal();
            canGo.signal();

        } finally {
            lock.unlock();
        }
    }
   
}
