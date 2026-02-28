import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_706 {
    public static ArrayList<String> f(String r, String w) {
        ArrayList<String> a = new ArrayList<>();
        if (r.charAt(0) == w.charAt(0) && w.charAt(w.length() - 1) == r.charAt(r.length() - 1)) {
            a.add(r);
            a.add(w);
        } else {
            a.add(w);
            a.add(r);
        }
        return a;
    }
    public static void main(String[] args) {
    assert(f(("ab"), ("xy")).equals((new ArrayList<String>(Arrays.asList((String)"xy", (String)"ab")))));
    }

}
