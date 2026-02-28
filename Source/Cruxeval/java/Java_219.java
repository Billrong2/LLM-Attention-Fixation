import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_219 {
    public static boolean f(String s1, String s2) {
        int length = s2.length() + s1.length();
        for (int k = 0; k < length; k++) {
            s1 += s1.charAt(0);
            if (s1.indexOf(s2) >= 0) {
                return true;
            }
        }
        return false;
    }
    public static void main(String[] args) {
    assert(f(("Hello"), (")")) == (false));
    }

}
