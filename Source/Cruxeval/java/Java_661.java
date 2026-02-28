import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_661 {
    public static String f(String letters, long maxsplit) {
        String[] words = letters.split("\\s");
        long len = words.length;
        StringBuilder sb = new StringBuilder();
        for (int i = (int)Math.max(0, len - maxsplit); i < len; i++) {
            sb.append(words[i]);
        }
        return sb.toString();
    }
    public static void main(String[] args) {
    assert(f(("elrts,SS ee"), (6l)).equals(("elrts,SSee")));
    }

}
