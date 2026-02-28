import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_016 {
    public static String f(String text, String suffix) {
        if (text.endsWith(suffix)) {
            return text.substring(0, text.length() - suffix.length());
        }
        return text;
    }
    public static void main(String[] args) {
    assert(f(("zejrohaj"), ("owc")).equals(("zejrohaj")));
    }

}
