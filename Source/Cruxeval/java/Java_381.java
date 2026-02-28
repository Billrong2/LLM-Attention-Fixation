import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_381 {
    public static String f(String text, long num_digits) {
        int width = Math.max(1, (int) num_digits);
        return String.format("%0" + width + "d", Long.parseLong(text));
    }
    public static void main(String[] args) {
    assert(f(("19"), (5l)).equals(("00019")));
    }

}
