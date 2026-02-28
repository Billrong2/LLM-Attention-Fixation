import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_032 {
    public static String f(String s, String sep) {
        String[] parts = s.split(sep);
        List<String> reversedParts = new ArrayList<>();
        for (String part : parts) {
            reversedParts.add("*" + part);
        }
        Collections.reverse(reversedParts);
        return String.join(";", reversedParts);
    }
    public static void main(String[] args) {
    assert(f(("volume"), ("l")).equals(("*ume;*vo")));
    }

}
