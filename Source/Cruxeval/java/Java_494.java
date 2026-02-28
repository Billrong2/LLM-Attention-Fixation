import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_494 {
    public static String f(String num, long l) {
        String t = "";
        while (l > num.length()) {
            t += '0';
            l--;
        }
        return t + num;
    }
    public static void main(String[] args) {
    assert(f(("1"), (3l)).equals(("001")));
    }

}
