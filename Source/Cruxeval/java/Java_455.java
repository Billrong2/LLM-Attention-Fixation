import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_455 {
    public static String f(String text) {
        int uppers = 0;
        for (char c : text.toCharArray()) {
            if (Character.isUpperCase(c)) {
                uppers++;
            }
        }
        return uppers >= 10 ? text.toUpperCase() : text;
    }
    public static void main(String[] args) {
    assert(f(("?XyZ")).equals(("?XyZ")));
    }

}
