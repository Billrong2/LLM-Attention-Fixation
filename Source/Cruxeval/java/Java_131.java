import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_131 {
    public static long f(String text) {
        long a = text.length();
        long count = 0;
        while (!text.isEmpty()) {
            if (text.charAt(0) == 'a') {
                count += text.indexOf(' ');
            } else {
                count += text.indexOf('\n');
            }
            text = text.substring(text.indexOf('\n') + 1, Math.min(text.length(), text.indexOf('\n') + 1 + (int)a));
        }
        return count;    }
    public static void main(String[] args) {
    assert(f(("a\nkgf\nasd\n")) == (1l));
    }

}
