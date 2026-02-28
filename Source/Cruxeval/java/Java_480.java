import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_480 {
    public static String f(String s, String c1, String c2) {
        if (s.equals("")) {
            return s;
        }
        String[] ls = s.split(c1);
        for (int index = 0; index < ls.length; index++) {
            if (ls[index].contains(c1)) {
                ls[index] = ls[index].replaceFirst(c1, c2);
            }
        }
        return String.join(c1, ls);
    }
    public static void main(String[] args) {
    assert(f((""), ("mi"), ("siast")).equals(("")));
    }

}
