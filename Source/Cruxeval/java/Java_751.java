import java.io.*;
import java.lang.reflect.*;
import java.math.*;
import java.security.*;
import java.util.*;
import java.util.stream.*;
import org.javatuples.*;
import java.util.*;

class Java_751 {
    public static String f(String text, String character, long min_count) {
        long count = text.chars().filter(c -> c == character.charAt(0)).count();
        if (count < min_count) {
            return text.toUpperCase();
        }
        return text;
    }
    public static void main(String[] args) {
    assert(f(("wwwwhhhtttpp"), ("w"), (3l)).equals(("wwwwhhhtttpp")));
    }

}
