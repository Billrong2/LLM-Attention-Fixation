import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_337 {
    public static String f(String txt) {
        List<Character> d = new ArrayList<>();
        for(char c : txt.toCharArray()) {
            if(Character.isDigit(c)) {
                continue;
            }
            if(Character.isLowerCase(c)) {
                d.add(Character.toUpperCase(c));
            } else if(Character.isUpperCase(c)) {
                d.add(Character.toLowerCase(c));
            }
        }
        StringBuilder result = new StringBuilder();
        for(char ch : d) {
            result.append(ch);
        }
        return result.toString();
    }
    public static void main(String[] args) {
    assert(f(("5ll6")).equals(("LL")));
    }

}
