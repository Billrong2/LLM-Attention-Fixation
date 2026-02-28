import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_602 {
    public static long f(ArrayList<Long> nums, long target) {
        long cnt = nums.stream().filter(num -> num == target).count();
        return cnt * 2;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)1l, (long)1l))), (1l)) == (4l));
    }

}
