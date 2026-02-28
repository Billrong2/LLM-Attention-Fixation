import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_528 {
    public static long f(String s) {
        String b = "";
        String c = "";
        for (int i = 0; i < s.length(); i++) {
            c = c + s.charAt(i);
            if (s.lastIndexOf(c) > -1) {
                return s.lastIndexOf(c);
            }
        }
        return 0;
    }
    public static void main(String[] args) {
    assert(f(("papeluchis")) == (2l));
    }

}
