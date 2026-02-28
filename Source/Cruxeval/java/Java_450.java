import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_450 {
    public static String f(String strs) {
        String[] words = strs.split(" ");
        for (int i = 1; i < words.length; i += 2) {
            words[i] = new StringBuilder(words[i]).reverse().toString();
        }
        return String.join(" ", words);
    }
    public static void main(String[] args) {
    assert(f(("K zBK")).equals(("K KBz")));
    }

}
