import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_347 {
    public static String f(String text) {
        List<Character> ls = new ArrayList<>();
        for (char c : text.toCharArray()) {
            ls.add(c);
        }
        int length = ls.size();
        for (int i = 0; i < length; i++) {
            ls.add(i, ls.get(i));
        }
        StringBuilder sb = new StringBuilder();
        for (Character c : ls) {
            sb.append(c);
        }
        return sb.toString() + String.join("", Collections.nCopies(length * 2 - ls.size(), " "));
    }
    public static void main(String[] args) {
    assert(f(("hzcw")).equals(("hhhhhzcw")));
    }

}
