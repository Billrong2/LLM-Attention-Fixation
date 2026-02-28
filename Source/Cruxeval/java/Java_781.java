import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_781 {
    public static String f(String s, String ch) {
        if (!s.contains(ch)) {
            return "";
        }
        s = s.substring(s.indexOf(ch) + 1);
        for (int i = 0; i < s.length(); i++) {
            s = s.substring(s.indexOf(ch) + 1);
        }
        return s;
    }
    public static void main(String[] args) {
    assert(f(("shivajimonto6"), ("6")).equals(("")));
    }

}
