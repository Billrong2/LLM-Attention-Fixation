import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_054 {
    public static long f(String text, long s, long e) {
        String sublist = text.substring((int)s, (int)e);
        if (sublist.isEmpty()) {
            return -1;
        }
        return sublist.indexOf(Collections.min(sublist.codePoints().mapToObj(c -> String.valueOf((char) c)).collect(Collectors.toList())));
    }
    public static void main(String[] args) {
    assert(f(("happy"), (0l), (3l)) == (1l));
    }

}
