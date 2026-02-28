import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_614 {
    public static long f(String text, String substr, long occ) {
        long n = 0;
        while (true) {
            long i = text.lastIndexOf(substr);
            if (i == -1) {
                break;
            } else if (n == occ) {
                return i;
            } else {
                n++;
                text = text.substring(0, (int)i);
            }
        }
        return -1;
    }
    public static void main(String[] args) {
    assert(f(("zjegiymjc"), ("j"), (2l)) == (-1l));
    }

}
