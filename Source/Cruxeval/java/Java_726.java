import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_726 {
    public static Pair<Long, Long> f(String text) {
        long ws = 0;
        for (char s : text.toCharArray()) {
            if (Character.isWhitespace(s)) {
                ws += 1;
            }
        }
        return Pair.with(ws, (long) text.length());
    }
    public static void main(String[] args) {
    assert(f(("jcle oq wsnibktxpiozyxmopqkfnrfjds")).equals((Pair.with(2l, 34l))));
    }

}
