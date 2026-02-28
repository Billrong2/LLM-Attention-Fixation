import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_352 {
    public static long f(ArrayList<Long> nums) {
        return nums.get(nums.size() / 2);
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)-1l, (long)-3l, (long)-5l, (long)-7l, (long)0l)))) == (-5l));
    }

}
