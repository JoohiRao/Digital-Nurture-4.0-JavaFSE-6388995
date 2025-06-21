package singleton;
public class SingletonTest {
    public static void main(String[] args){

        // Get the first instance of Logger
        Logger log1=Logger.getInstance();
        System.out.println();

        // Log a message using the first instance
        log1.log("This is the first log message");

        // Get another instance of Logger
        Logger log2=Logger.getInstance();
        log2.log("This is the second log message");

        // Check if both logger references point to the same instance
        if(log1==log2){
            System.out.println("Logger instances are the same");
        }
        else{
            System.out.println("Logger instances are different");
        }

    }

}

