import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_635 {
    public static boolean f(String text) {
        char[] validChars = {'-', '_', '+', '.', '/', ' '};
        text = text.toUpperCase();
        for (char ch : text.toCharArray()) {
            if (!Character.isLetterOrDigit(ch) && !Arrays.asList(validChars).contains(ch)) {
                return false;
            }
        }
        return true;
    }
    public static void main(String[] args) {
    assert(f(("9.twCpTf.H7 HPeaQ^ C7I6U,C:YtW")) == (false));
    }

}
