import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_708 {
    public static String f(String string) {
        List<Character> l = new ArrayList<>();
        for (char c : string.toCharArray()) {
            l.add(c);
        }
        for (int i = l.size() - 1; i >= 0; i--) {
            if (l.get(i) != ' ') {
                break;
            }
            l.remove(i);
        }
        return l.stream()
                .map(String::valueOf)
                .collect(Collectors.joining());
    }
    public static void main(String[] args) {
    assert(f(("    jcmfxv     ")).equals(("    jcmfxv")));
    }

}
