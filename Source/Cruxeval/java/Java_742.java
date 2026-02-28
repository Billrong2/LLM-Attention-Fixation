import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_742 {
    public static boolean f(String text) {
        boolean b = true;
        for (char x : text.toCharArray()) {
            if (Character.isDigit(x)) {
                b = true;
            } else {
                b = false;
                break;
            }
        }
        return b;
    }
    public static void main(String[] args) {
    assert(f(("-1-3")) == (false));
    }

}
