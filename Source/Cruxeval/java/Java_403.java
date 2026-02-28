import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_403 {
    public static long f(String full, String part) {
        int length = part.length();
        int index = full.indexOf(part);
        int count = 0;
        while (index >= 0) {
            full = full.substring(index + length);
            index = full.indexOf(part);
            count++;
        }
        return count;
    }
    public static void main(String[] args) {
    assert(f(("hrsiajiajieihruejfhbrisvlmmy"), ("hr")) == (2l));
    }

}
