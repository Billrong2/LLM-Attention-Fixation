import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_027 {
    public static boolean f(String w) {
        List<Character> ls = new ArrayList<>();
        for (char c : w.toCharArray()) {
            ls.add(c);
        }
        StringBuilder omw = new StringBuilder();
        while (!ls.isEmpty()) {
            omw.append(ls.remove(0));
            if (ls.size() * 2 > w.length()) {
                if (w.substring(ls.size()).equals(omw.toString())) {
                    return true;
                }
            }
        }
        return false;
    }
    public static void main(String[] args) {
    assert(f(("flak")) == (false));
    }

}
