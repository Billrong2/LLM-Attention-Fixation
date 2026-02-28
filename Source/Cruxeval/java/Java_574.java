import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_574 {
    public static String f(ArrayList<String> simpons) {
        while (!simpons.isEmpty()) {
            String pop = simpons.remove(simpons.size() - 1);
            if (pop.equals(pop.substring(0, 1).toUpperCase() + pop.substring(1))) {
                return pop;
            }
        }
        return simpons.get(simpons.size() - 1);
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<String>(Arrays.asList((String)"George", (String)"Michael", (String)"George", (String)"Costanza")))).equals(("Costanza")));
    }

}
