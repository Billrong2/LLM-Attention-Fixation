import java.io.*;
import java.lang.reflect.*;
import java.math.*;
import java.security.*;
import java.util.*;
import java.util.stream.*;
import org.javatuples.*;
import java.util.*;

class Java_199 {
    public static String f(String s, String character) {
        int count = 0;
        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) == character.charAt(0)) {
                count++;
            }
        }
        String base = String.valueOf(character.repeat(count + 1));
        
        return s.endsWith(base) ? s.substring(0, s.length() - base.length()) : s;
    }
    public static void main(String[] args) {
    assert(f(("mnmnj krupa...##!@#!@#$$@##"), ("@")).equals(("mnmnj krupa...##!@#!@#$$@##")));
    }

}
