import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_056 {
    public static boolean f(String sentence) {
        for (char c : sentence.toCharArray()) {
            if (!String.valueOf(c).matches("\\p{ASCII}")) {
                return false;
            }
        }
        return true;
    }
    public static void main(String[] args) {
    assert(f(("1z1z1")) == (true));
    }

}
