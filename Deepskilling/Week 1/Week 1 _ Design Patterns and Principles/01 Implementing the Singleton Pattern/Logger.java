package singleton;
public class Logger {
    //private static instance of the class
    private static Logger instance;

    // Private constructor to prevent instantiation from other classes
    private Logger(){
        System.out.println("Logger Initialized");
    }

    // Public static method to get the single instance of the class
    public static Logger getInstance(){
        if(instance==null){
            instance=new Logger();
        }
        return instance;
    }

    public void log(String message){
        System.out.println("LOG : "+message);
    }



}

