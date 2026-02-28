import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_488 {
    public static String f(String text, String charStr) {
        int count = text.length() - text.replace(charStr, "").length();
        char[] chars = text.toCharArray();
        if (count > 0) {
            int index = new String(chars).indexOf(charStr) + 1;
            for (int i = 0; i < count; i++) {
                chars[i] = chars[index + i];
            }
        }
        return new String(chars);
    }
    public static void main(String[] args) {
    assert(f(("tezmgvn 651h"), ("6")).equals(("5ezmgvn 651h")));
    }

}
