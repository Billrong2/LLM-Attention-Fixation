import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_210 {
    public static long f(long n, long m, long num) {
        List<Long> xList = new ArrayList<>();
        for (long i = n; i <= m; i++) {
            xList.add(i);
        }
        int j = 0;
        while (true) {
            j = (j + (int) num) % xList.size();
            if (xList.get(j) % 2 == 0) {
                return xList.get(j);
            }
        }
    }
    public static void main(String[] args) {
    assert(f((46l), (48l), (21l)) == (46l));
    }

}
