import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_596 {
    public static ArrayList<String> f(ArrayList<String> txt, String alpha) {
        Collections.sort(txt);
        if (txt.indexOf(alpha) % 2 == 0) {
            Collections.reverse(txt);
        }
        return txt;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<String>(Arrays.asList((String)"8", (String)"9", (String)"7", (String)"4", (String)"3", (String)"2"))), ("9")).equals((new ArrayList<String>(Arrays.asList((String)"2", (String)"3", (String)"4", (String)"7", (String)"8", (String)"9")))));
    }

}
