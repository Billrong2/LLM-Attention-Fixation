import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_606 {
    public static String f(String value) {
        List<Character> ls = new ArrayList<Character>();
        for (char c : value.toCharArray()) {
            ls.add(c);
        }
        ls.add('N');
        ls.add('H');
        ls.add('I');
        ls.add('B');
        StringBuilder sb = new StringBuilder();
        for (Character c : ls) {
            sb.append(c);
        }
        return sb.toString();
    }
    public static void main(String[] args) {
    assert(f(("ruam")).equals(("ruamNHIB")));
    }

}
