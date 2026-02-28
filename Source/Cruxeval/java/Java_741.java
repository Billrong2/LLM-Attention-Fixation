import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_741 {
    public static long f(ArrayList<Long> nums, long p) {
        long prev_p = p - 1;
        if (prev_p < 0) {
            prev_p = nums.size() - 1;
        }
        return nums.get((int)prev_p);
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)6l, (long)8l, (long)2l, (long)5l, (long)3l, (long)1l, (long)9l, (long)7l))), (6l)) == (1l));
    }

}
