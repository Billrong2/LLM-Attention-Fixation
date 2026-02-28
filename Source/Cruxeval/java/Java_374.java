import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_374 {
    public static ArrayList<String> f(ArrayList<String> seq, String v) {
        ArrayList<String> a = new ArrayList<>();
        for (String i : seq) {
            if (i.endsWith(v)) {
                a.add(i + i);
            }
        }
        return a;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<String>(Arrays.asList((String)"oH", (String)"ee", (String)"mb", (String)"deft", (String)"n", (String)"zz", (String)"f", (String)"abA"))), ("zz")).equals((new ArrayList<String>(Arrays.asList((String)"zzzz")))));
    }

}
