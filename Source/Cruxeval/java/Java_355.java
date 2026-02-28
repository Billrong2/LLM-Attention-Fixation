import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_355 {
    public static String f(String text, String prefix) {
        return text.substring(prefix.length());
    }
    public static void main(String[] args) {
    assert(f(("123x John z"), ("z")).equals(("23x John z")));
    }

}
