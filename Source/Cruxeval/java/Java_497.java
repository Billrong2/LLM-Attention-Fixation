import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_497 {
    public static ArrayList<String> f(long n) {
        String[] b = String.valueOf(n).split("");
        for (int i = 2; i < b.length; i++) {
            b[i] += "+";
        }
        return new ArrayList<>(Arrays.asList(b));
    }
    public static void main(String[] args) {
    assert(f((44l)).equals((new ArrayList<String>(Arrays.asList((String)"4", (String)"4")))));
    }

}
