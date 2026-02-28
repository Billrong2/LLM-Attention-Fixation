import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_682 {
    public static String f(String text, long length, long index) {
        String[] ls = text.split(" ", (int) index + 1);
        StringJoiner joiner = new StringJoiner("_");
        for (String l : ls) {
            joiner.add(l.substring(0, (int) length));
        }
        return joiner.toString();
    }
    public static void main(String[] args) {
    assert(f(("hypernimovichyp"), (2l), (2l)).equals(("hy")));
    }

}
