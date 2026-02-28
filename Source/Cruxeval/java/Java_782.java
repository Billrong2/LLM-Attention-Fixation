import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_782 {
    public static boolean f(String input) {
        for (char ch : input.toCharArray()) {
            if (Character.isUpperCase(ch)) {
                return false;
            }
        }
        return true;
    }
    public static void main(String[] args) {
    assert(f(("a j c n x X k")) == (false));
    }

}
