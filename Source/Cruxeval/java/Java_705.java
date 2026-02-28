import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_705 {
    public static ArrayList<String> f(ArrayList<String> cities, String name) {
        ArrayList<String> result = new ArrayList<>();
        if (name.isEmpty()) {
            return cities;
        }
        if (!name.isEmpty() && !name.equals("cities")) {
            return result;
        }
        for (String city : cities) {
            result.add(name + city);
        }
        return result;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<String>(Arrays.asList((String)"Sydney", (String)"Hong Kong", (String)"Melbourne", (String)"Sao Paolo", (String)"Istanbul", (String)"Boston"))), ("Somewhere ")).equals((new ArrayList<String>(Arrays.asList()))));
    }

}
