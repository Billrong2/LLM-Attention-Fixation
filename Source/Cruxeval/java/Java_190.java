import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_190 {
    public static String f(String text) {
        String shortStr = "";
        for (int i = 0; i < text.length(); i++) {
            char c = text.charAt(i);
            if (Character.isLowerCase(c)) {
                shortStr += c;
            }
        }
        return shortStr;
    }
    public static void main(String[] args) {
    assert(f(("980jio80jic kld094398IIl ")).equals(("jiojickldl")));
    }

}
