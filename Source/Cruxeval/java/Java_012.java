import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_012 {
    public static String f(String s, String x) {
        int count = 0;
        while (s.substring(0, Math.min(s.length(), x.length())).equals(x) && count < s.length() - x.length()) {
            s = s.substring(x.length());
            count += x.length();
        }
        return s;
    }
    public static void main(String[] args) {
    assert(f(("If you want to live a happy life! Daniel"), ("Daniel")).equals(("If you want to live a happy life! Daniel")));
    }

}
