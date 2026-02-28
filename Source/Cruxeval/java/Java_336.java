import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_336 {
    public static String f(String s, String sep) {
        s += sep;
        return s.substring(0, s.lastIndexOf(sep));
    }
    public static void main(String[] args) {
    assert(f(("234dsfssdfs333324314"), ("s")).equals(("234dsfssdfs333324314")));
    }

}
