import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_427 {
    public static String f(String s) {
        int count = s.length() - 1;
        StringBuilder reverse_s = new StringBuilder(s).reverse();
        while (count > 0 && reverse_s.substring(0, count).replaceAll("..", "").indexOf("sea") == -1) {
            count--;
            reverse_s.delete(count, reverse_s.length());
        }
        return reverse_s.substring(count);
    }
    public static void main(String[] args) {
    assert(f(("s a a b s d s a a s a a")).equals(("")));
    }

}
