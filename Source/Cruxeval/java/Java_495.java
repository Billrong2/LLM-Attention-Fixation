import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;

class Java_495 {
    public static Pair<String, String> f(String s) {
        if (s.length() >= 5 && isAscii(s.substring(s.length() - 5))) {
            return new Pair<>(s.substring(s.length() - 5), s.substring(0, 3));
        } else if (s.length() >= 5 && isAscii(s.substring(0, 5))) {
            return new Pair<>(s.substring(0, 5), s.substring(s.length() - 2));
        } else {
            return new Pair<>(s, "");
        }
    }

    public static boolean isAscii(String s) {
        return s.chars().allMatch(c -> c < 128);
    }
    public static void main(String[] args) {
    assert(f(("a1234år")).equals((Pair.with("a1234", "år"))));
    }

}
