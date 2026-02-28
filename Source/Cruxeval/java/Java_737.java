import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_737 {
    public static long f(ArrayList<Long> nums) {
        int counts = 0;
        for (long i : nums) {
            if (String.valueOf(i).matches("\\d+")) {
                if (counts == 0) {
                    counts += 1;
                }
            }
        }
        return counts;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)0l, (long)6l, (long)2l, (long)-1l, (long)-2l)))) == (1l));
    }

}
