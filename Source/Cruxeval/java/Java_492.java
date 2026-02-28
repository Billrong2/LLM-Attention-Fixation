import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_492 {
    public static String f(String text, String value) {
        List<Character> ls = new ArrayList<>(text.chars().mapToObj(c -> (char) c).collect(Collectors.toList()));
        if (Collections.frequency(ls, value) % 2 == 0) {
            while (ls.contains(value)) {
                ls.remove(ls.indexOf(value));
            }
        } else {
            ls.clear();
        }
        StringBuilder sb = new StringBuilder();
        for (Character ch : ls) {
            sb.append(ch);
        }
        return sb.toString();
    }
    public static void main(String[] args) {
    assert(f(("abbkebaniuwurzvr"), ("m")).equals(("abbkebaniuwurzvr")));
    }

}
