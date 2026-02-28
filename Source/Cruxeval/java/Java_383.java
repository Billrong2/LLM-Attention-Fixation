import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_383 {
    public static String f(String text, String chars) {
        List<Character> result = new ArrayList<>();
        for (char c : text.toCharArray()) {
            result.add(c);
        }
        while (result.subList(Math.max(result.size() - 3, 0), result.size()).contains(chars.charAt(0))) {
            result.remove(result.size() - 3);
            result.remove(result.size() - 3);
        }
        StringBuilder sb = new StringBuilder();
        for (char c : result) {
            sb.append(c);
        }
        return sb.toString().replaceAll("\\.$", "");
    }
    public static void main(String[] args) {
    assert(f(("ellod!p.nkyp.exa.bi.y.hain"), (".n.in.ha.y")).equals(("ellod!p.nkyp.exa.bi.y.hain")));
    }

}
