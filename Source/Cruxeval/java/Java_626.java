import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_626 {
    public static String f(String line, ArrayList<Pair<String, String>> equalityMap) {
        Map<Character, Character> rs = new HashMap<>();
        for (Pair<String, String> pair : equalityMap) {
            rs.put(pair.getValue0().charAt(0), pair.getValue1().charAt(0));
        }
        StringBuilder sb = new StringBuilder();
        for (char c : line.toCharArray()) {
            sb.append(rs.getOrDefault(c, c));
        }
        return sb.toString();    }
    public static void main(String[] args) {
    assert(f(("abab"), (new ArrayList<Pair<String, String>>(Arrays.asList((Pair<String, String>)Pair.with("a", "b"), (Pair<String, String>)Pair.with("b", "a"))))).equals(("baba")));
    }

}
