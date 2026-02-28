import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_459 {
    public static HashMap<String,String> f(ArrayList<String> arr, HashMap<String,String> d) {
        for (int i = 1; i < arr.size(); i += 2) {
            d.put(arr.get(i), arr.get(i - 1));
        }
        return d;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<String>(Arrays.asList((String)"b", (String)"vzjmc", (String)"f", (String)"ae", (String)"0"))), (new HashMap<String,String>())).equals((new HashMap<String,String>(Map.of("vzjmc", "b", "ae", "f")))));
    }

}
