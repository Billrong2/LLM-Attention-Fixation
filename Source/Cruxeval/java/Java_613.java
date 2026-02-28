import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_613 {
    public static String f(String text) {
        String result = "";
        int mid = (text.length() - 1) / 2;
        for (int i = 0; i < mid; i++) {
            result += text.charAt(i);
        }
        for (int i = mid; i < text.length() - 1; i++) {
            result += text.charAt(mid + text.length() - 1 - i);
        }
        return result + String.join("", Collections.nCopies(text.length() - result.length(), String.valueOf(text.charAt(text.length() - 1))));
    }
    public static void main(String[] args) {
    assert(f(("eat!")).equals(("e!t!")));
    }

}
