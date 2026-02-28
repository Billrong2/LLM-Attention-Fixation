import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_264 {
    public static String f(String test_str) {
        String s = test_str.replace("a", "A");
        return s.replace("e", "A");
    }
    public static void main(String[] args) {
    assert(f(("papera")).equals(("pApArA")));
    }

}
