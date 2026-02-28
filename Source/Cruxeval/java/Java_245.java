import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_245 {
    public static ArrayList<String> f(String alphabet, String s) {
        ArrayList<String> a = new ArrayList<>();
        for (char x : alphabet.toCharArray()) {
            if (Character.toUpperCase(x) == x) {
                a.add(String.valueOf(x));
            }
        }
        if (s.toUpperCase().equals(s)) {
            a.add("all_uppercased");
        }
        return a;
    }
    public static void main(String[] args) {
    assert(f(("abcdefghijklmnopqrstuvwxyz"), ("uppercased # % ^ @ ! vz.")).equals((new ArrayList<String>(Arrays.asList()))));
    }

}
