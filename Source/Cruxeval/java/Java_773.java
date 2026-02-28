import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_773 {
    public static long f(ArrayList<Long> nums, long n) {
        return nums.remove((int)n);
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)-7l, (long)3l, (long)1l, (long)-1l, (long)-1l, (long)0l, (long)4l))), (6l)) == (4l));
    }

}
