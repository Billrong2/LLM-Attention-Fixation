import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;

class Java_389 {
    public static ArrayList<String> f(ArrayList<String> total, String arg) {
        if (arg.startsWith("[") && arg.endsWith("]")) {
            String[] array = arg.substring(1, arg.length() - 1).replaceAll(" ", "").split(",");
            total.addAll(Arrays.asList(array));
        } else {
            total.addAll(Arrays.asList(arg.split("")));
        }
        return total;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<String>(Arrays.asList((String)"1", (String)"2", (String)"3"))), ("nammo")).equals((new ArrayList<String>(Arrays.asList((String)"1", (String)"2", (String)"3", (String)"n", (String)"a", (String)"m", (String)"m", (String)"o")))));
    }

}
