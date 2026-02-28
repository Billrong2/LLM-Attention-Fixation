import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_274 {
    public static long f(ArrayList<Long> nums, long target) {
        long count = 0;
        for (long n1 : nums) {
            for (long n2 : nums) {
                count += (n1 + n2 == target) ? 1 : 0;
            }
        }
        return count;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)1l, (long)2l, (long)3l))), (4l)) == (3l));
    }

}
