import java.io.*;
import java.lang.reflect.*;
import java.math.*;
import java.nio.charset.Charset;
import java.security.*;
import java.util.*;
import java.util.stream.*;
import org.javatuples.*;
class Java_617 {
    public static String f(String text) {
        if (Charset.forName("US-ASCII").newEncoder().canEncode(text)) {
            return "ascii";
        } else {
            return "non ascii";
        }
    }
    public static void main(String[] args) {
    assert(f(("<<<<")).equals(("ascii")));
    }

}
