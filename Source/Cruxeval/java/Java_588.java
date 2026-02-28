import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_588 {
    public static long f(ArrayList<String> items, String target) {
        if (items.contains(target)) {
            return items.indexOf(target);
        }
        return -1;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<String>(Arrays.asList((String)"1", (String)"+", (String)"-", (String)"**", (String)"//", (String)"*", (String)"+"))), ("**")) == (3l));
    }

}
