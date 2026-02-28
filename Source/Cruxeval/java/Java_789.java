import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_789 {
    public static String f(String text, long n) {
        if (n < 0 || text.length() <= n) {
            return text;
        }
        String result = text.substring(0, (int)n);
        int i = result.length() - 1;
        while (i >= 0) {
            if (result.charAt(i) != text.charAt(i)) {
                break;
            }
            i--;
        }
        return text.substring(0, i + 1);
    }
    public static void main(String[] args) {
    assert(f(("bR"), (-1l)).equals(("bR")));
    }

}
