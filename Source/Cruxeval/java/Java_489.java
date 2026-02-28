import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_489 {
    public static String f(String text, String value) {
        return text.toLowerCase().startsWith(value.toLowerCase()) ? text.substring(value.length()).toLowerCase() : text;
    }
    public static void main(String[] args) {
    assert(f(("coscifysu"), ("cos")).equals(("cifysu")));
    }

}
