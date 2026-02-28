import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_093 {
    public static String f(String n) {
        int length = n.length() + 2;
        List<Character> revn = new ArrayList<Character>();
        for (char c : n.toCharArray()) {
            revn.add(c);
        }
        StringBuilder result = new StringBuilder();
        for (char c : revn) {
            result.append(c);
        }
        revn.clear();
        return result.toString() + "!".repeat(length);
    }
    public static void main(String[] args) {
    assert(f(("iq")).equals(("iq!!!!")));
    }

}
