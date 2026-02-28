import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_654 {
    public static String f(String s, String from_c, String to_c) {
        return s.replaceAll("[" + from_c + "]", to_c);
    }
    public static void main(String[] args) {
    assert(f(("aphid"), ("i"), ("?")).equals(("aph?d")));
    }

}
