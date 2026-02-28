import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;

class Java_669 {
    public static String f(String t) {
        int i = t.lastIndexOf('-');
        if (i == -1) return t;

        String a = t.substring(0, i);
        String b = t.substring(i+1);

        if (b.length() == a.length()) return "imbalanced";

        return a + b;
    }
    public static void main(String[] args) {
    assert(f(("fubarbaz")).equals(("fubarbaz")));
    }

}
