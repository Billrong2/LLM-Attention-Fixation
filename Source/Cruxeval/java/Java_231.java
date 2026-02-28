import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_231 {
    public static long f(ArrayList<Long> years) {
        long a10 = years.stream().filter(x -> x <= 1900).count();
        long a90 = years.stream().filter(x -> x > 1910).count();
        if (a10 > 3) {
            return 3;
        } else if (a90 > 3) {
            return 1;
        } else {
            return 2;
        }
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)1872l, (long)1995l, (long)1945l)))) == (2l));
    }

}
