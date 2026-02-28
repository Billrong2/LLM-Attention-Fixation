import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_080 {
    public static String f(String s) {
        return new StringBuilder(s.trim()).reverse().toString();
    }
    public static void main(String[] args) {
    assert(f(("ab        ")).equals(("ba")));
    }

}
