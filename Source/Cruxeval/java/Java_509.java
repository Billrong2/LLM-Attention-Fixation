import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_509 {
    public static String f(long value, long width) {
        if (value >= 0) {
            return String.format("%0" + width + "d", value);
        } else {
            return "-" + String.format("%0" + width + "d", -value);
        }
    }
    public static void main(String[] args) {
    assert(f((5l), (1l)).equals(("5")));
    }

}
