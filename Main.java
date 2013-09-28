import java.io.*;
import java.util.*;

class Main {
    public static void main(String... args) throws IOException {
        String filename = args[0];
        Dataset data = new Dataset(filename);

        Dataset bootstrapped = data.bootstrap(data.size); 
        System.out.println(bootstrapped);
    }
}
