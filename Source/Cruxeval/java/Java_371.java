import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_371 {
    public static long f(ArrayList<Long> nums) {
        nums.removeIf(num -> num % 2 != 0);
        long sum = 0;
        for (long num : nums) {
            sum += num;
        }
        return sum;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)11l, (long)21l, (long)0l, (long)11l)))) == (0l));
    }

}
