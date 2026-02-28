import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_279 {
    public static String f(String text) {
        String ans = "";
        while (!text.isEmpty()) {
            String[] parts = text.split("\\(", 2);
            String x = parts[0];
            String sep = "(";
            text = parts[1];
            ans = x + sep.replace("(", "|") + ans;
            ans = ans + text.charAt(0) + ans;
            text = text.substring(1);
        }
        return ans;
    }
    public static void main(String[] args) {
    assert(f(("")).equals(("")));
    }

}
