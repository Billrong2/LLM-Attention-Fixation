import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_628 {
    public static ArrayList<Long> f(ArrayList<Long> nums, long delete) {
        nums.removeIf(num -> num == delete);
        return nums;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)4l, (long)5l, (long)3l, (long)6l, (long)1l))), (5l)).equals((new ArrayList<Long>(Arrays.asList((long)4l, (long)3l, (long)6l, (long)1l)))));
    }

}
