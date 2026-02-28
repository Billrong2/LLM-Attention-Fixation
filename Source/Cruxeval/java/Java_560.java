import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_560 {
    public static long f(String text) {
        long x = 0;
        if (text.equals(text.toLowerCase()) && text.matches("[a-z]*")) {
            for (char c : text.toCharArray()) {
                int ascii = (int) c;
                if (ascii >= 48 && ascii <= 57) {
                    x++;
                }
            }
        }
        return x;
    }
    public static void main(String[] args) {
    assert(f(("591237865")) == (0l));
    }

}
