import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_561 {
    public static long f(String text, String digit) {
        int count = text.split(digit, -1).length - 1;
        return Integer.parseInt(digit) * count;
    }
    public static void main(String[] args) {
    assert(f(("7Ljnw4Lj"), ("7")) == (7l));
    }

}
