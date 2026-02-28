import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_065 {
    public static long f(ArrayList<Long> nums, long index) {
        long result = nums.get((int)index) % 42 + nums.remove((int)index) * 2;
        return result;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)3l, (long)2l, (long)0l, (long)3l, (long)7l))), (3l)) == (9l));
    }

}
