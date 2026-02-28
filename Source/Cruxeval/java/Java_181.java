import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_181 {
    public static Pair<String, Long> f(String s) {
        long count = 0;
        String digits = "";
        for (Character c : s.toCharArray()) {
            if (Character.isDigit(c)) {
                count += 1;
                digits += c;
            }
        }
        return Pair.with(digits, count);
    }
    public static void main(String[] args) {
    assert(f(("qwfasgahh329kn12a23")).equals((Pair.with("3291223", 7l))));
    }

}
