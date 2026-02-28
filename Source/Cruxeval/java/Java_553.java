import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_553 {
    public static String f(String text, long count) {
        for (int i = 0; i < count; i++) {
            text = new StringBuilder(text).reverse().toString();
        }
        return text;
    }
    public static void main(String[] args) {
    assert(f(("439m2670hlsw"), (3l)).equals(("wslh0762m934")));
    }

}
