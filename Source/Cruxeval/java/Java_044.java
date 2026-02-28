import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_044 {
    public static String f(String text) {
        char[] ls = text.toCharArray();
        for (int i = 0; i < ls.length; i++) {
            if (ls[i] != '+') {
                ls = new StringBuilder(new String(ls)).insert(i, "*+").toString().toCharArray();
                break;
            }
        }
        return String.join("+", new String(ls).split(""));
    }
    public static void main(String[] args) {
    assert(f(("nzoh")).equals(("*+++n+z+o+h")));
    }

}
