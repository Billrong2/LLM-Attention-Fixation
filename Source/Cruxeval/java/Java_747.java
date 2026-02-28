import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_747 {
    public static boolean f(String text) {
        if (text.equals("42.42")) {
            return true;
        }
        for (int i = 3; i < text.length() - 3; i++) {
            if (text.charAt(i) == '.' && text.substring(i - 3).matches("\\d+") && text.substring(0, i).matches("\\d+")) {
                return true;
            }
        }
        return false;
    }
    public static void main(String[] args) {
    assert(f(("123E-10")) == (false));
    }

}
