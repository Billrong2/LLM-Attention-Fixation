import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_727 {
    public static ArrayList<String> f(ArrayList<String> numbers, String prefix) {
        ArrayList<String> result = new ArrayList<>();
        for (String n : numbers) {
            if (n.length() > prefix.length() && n.startsWith(prefix)) {
                result.add(n.substring(prefix.length()));
            } else {
                result.add(n);
            }
        }
        Collections.sort(result);
        return result;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<String>(Arrays.asList((String)"ix", (String)"dxh", (String)"snegi", (String)"wiubvu"))), ("")).equals((new ArrayList<String>(Arrays.asList((String)"dxh", (String)"ix", (String)"snegi", (String)"wiubvu")))));
    }

}
