import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_325 {
    public static boolean f(String s) {
        char[] l = s.toCharArray();
        for (int i = 0; i < l.length; i++) {
            l[i] = Character.toLowerCase(l[i]);
            if (!Character.isDigit(l[i])) {
                return false;
            }
        }
        return true;
    }
    public static void main(String[] args) {
    assert(f(("")) == (true));
    }

}
