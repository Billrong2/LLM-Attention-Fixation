import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_152 {
    public static long f(String text) {
        long n = 0;
        for (char char_ : text.toCharArray()) {
            if (Character.isUpperCase(char_)) {
                n += 1;
            }
        }
        return n;
    }
    public static void main(String[] args) {
    assert(f(("AAAAAAAAAAAAAAAAAAAA")) == (20l));
    }

}
