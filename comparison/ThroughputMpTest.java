//package inutil.local;

import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;

public class ThroughputMpTest {
    static   long n=10000000;

    static BlockingQueue<Integer> queue=new ArrayBlockingQueue<Integer>(1000);
    static class Consumer implements Runnable {
        @Override
        public void run() {
            long s=0;
            try { 
                long t0=System.currentTimeMillis();
                for(int i=0;i<n;i++) {
                    int x=queue.take();
                    s+=x;
                }
                long t1=System.currentTimeMillis();
                double d=t1-t0;
                System.out.println(n+" messages received in "+d+" ms, sum="+s+" speed: "+1000*d/n+" microsec/message, "+n/d+" messages/msec");
            } catch (Exception e){
                e.printStackTrace();
            }
        }
    }

    static class Producer implements Runnable {
        @Override
        public void run() {
            try {
                for(int i=0;i<n;i++) {
                    queue.put(i);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

    }

    public static void main(String[] args) throws InterruptedException {
        Thread t=new Thread(new Consumer());
        t.start();
        (new Thread(new Producer())).start();
        t.join();
    }
}
