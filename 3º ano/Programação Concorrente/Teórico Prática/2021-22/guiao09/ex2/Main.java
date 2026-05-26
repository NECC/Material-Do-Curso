import java.io.*;
import java.net.*;

public class Main {
    public static void main(String[] args) {
        try{
            if(args.length<2)
                System.exit(1);

            String host = args[0];
            int port = Integer.parseInt(args[1]);
            Socket s = new Socket(host, port);

            BufferedReader in = new BufferedReader(new InputStreamReader( s.getInputStream()));
            BufferedReader consoleIn = new BufferedReader(new InputStreamReader(System.in));
            PrintWriter out = new PrintWriter(s.getOutputStream());

            while (true) {
                System.out.print("> ");
                out.println(consoleIn.readLine());
                out.flush();

                String res = in.readLine();
                if (res == "close") System.exit(0);
                System.out.println(res);
            }
        } catch (Exception e){
            e.printStackTrace();
            System.exit(0);
        }
    }
}