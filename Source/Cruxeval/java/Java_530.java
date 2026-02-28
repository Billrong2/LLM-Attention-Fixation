import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_530 {
    public static String f(String s, String ch) {
        String sl = s;
        if (s.contains(ch)) {
            sl = s.replaceFirst("^" + ch + "+", "");
            if (sl.length() == 0) {
                sl = sl + "!?";
            }
        } else {
            return "no";
        }
        return sl;
    }
    public static void main(String[] args) {
    assert(f(("@@@ff"), ("@")).equals(("ff")));
    }

}
