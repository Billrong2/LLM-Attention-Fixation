import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_170 {
    public static long f(ArrayList<Long> nums, long number) {
        return nums.stream().filter(num -> num == number).count();
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)12l, (long)0l, (long)13l, (long)4l, (long)12l))), (12l)) == (2l));
    }

}
