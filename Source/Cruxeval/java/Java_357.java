import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_357 {
    public static String f(String s) {
        char[] r = new char[s.length()];
        int index = 0;
        for (int i = s.length() - 1; i >= 0; i--) {
            r[index++] = s.charAt(i);
        }
        return new String(r);
    }
    public static void main(String[] args) {
    assert(f(("crew")).equals(("werc")));
    }

}
