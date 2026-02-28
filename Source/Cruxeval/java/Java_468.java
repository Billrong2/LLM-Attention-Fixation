import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_468 {
    public static String f(String a, String b, long n) {
        String result = b;
        String m = b;
        for (int i = 0; i < n; i++) {
            if (m != null) {
                String[] parts = a.split(m, 2);
                if (parts.length == 2) {
                    a = parts[0] + parts[1];  
                    m = null;
                }
                result = m;
            }
        }
        String[] splitStrings = a.split(b);
        return String.join(result, splitStrings);
    }
    public static void main(String[] args) {
    assert(f(("unrndqafi"), ("c"), (2l)).equals(("unrndqafi")));
    }

}
