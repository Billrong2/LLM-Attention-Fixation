import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_783 {
    public static long f(String text, String comparison) {
        int length = comparison.length();
        if (length <= text.length()) {
            for (int i = 0; i < length; i++) {
                if (comparison.charAt(length - i - 1) != text.charAt(text.length() - i - 1)) {
                    return i;
                }
            }
        }
        return length;
    }
    public static void main(String[] args) {
    assert(f(("managed"), ("")) == (0l));
    }

}
