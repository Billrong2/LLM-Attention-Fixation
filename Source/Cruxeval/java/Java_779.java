import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_779 {
    public static String f(String text) {
        String[] values = text.split(" ");
        return String.format("${first}y, ${second}x, ${third}r, ${fourth}p",
                values[0], values[1], values[2], values[3]);
    }
    public static void main(String[] args) {
    assert(f(("python ruby c javascript")).equals(("${first}y, ${second}x, ${third}r, ${fourth}p")));
    }

}
