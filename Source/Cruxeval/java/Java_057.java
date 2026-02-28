import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_057 {
    public static long f(String text) {
        text = text.toUpperCase();
        int count_upper = 0;
        for (char c : text.toCharArray()) {
            if (Character.isUpperCase(c)) {
                count_upper++;
            } else {
                return -1;
            }
        }
        return count_upper / 2;
    }
    public static void main(String[] args) {
    assert(f(("ax")) == (1l));
    }

}
