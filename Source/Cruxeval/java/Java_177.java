import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_177 {
    public static String f(String text) {
        char[] chars = text.toCharArray();
        for (int i = 0; i < chars.length; i++) {
            if (i % 2 == 1) {
                chars[i] = Character.isUpperCase(chars[i]) ? Character.toLowerCase(chars[i]) : Character.toUpperCase(chars[i]);
            }
        }
        return new String(chars);
    }
    public static void main(String[] args) {
    assert(f(("Hey DUdE THis $nd^ &*&this@#")).equals(("HEy Dude tHIs $Nd^ &*&tHiS@#")));
    }

}
