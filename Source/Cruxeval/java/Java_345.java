import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_345 {
    public static Pair<String, String> f(String a, String b) {
        if (a.compareTo(b) < 0) {
            return new Pair<>(b, a);
        }
        return new Pair<>(a, b);
    }
    public static void main(String[] args) {
    assert(f(("ml"), ("mv")).equals((Pair.with("mv", "ml"))));
    }

}
