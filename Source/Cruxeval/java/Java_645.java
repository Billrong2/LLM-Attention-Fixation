import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_645 {
    public static long f(ArrayList<Long> nums, long target) {
        if (nums.stream().filter(num -> num == 0).count() > 0) {
            return 0;
        } else if (Collections.frequency(nums, target) < 3) {
            return 1;
        } else {
            return nums.indexOf(target);
        }
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)1l, (long)1l, (long)1l, (long)2l))), (3l)) == (1l));
    }

}
