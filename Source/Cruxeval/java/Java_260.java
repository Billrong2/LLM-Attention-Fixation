import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_260 {
    public static ArrayList<Long> f(ArrayList<Long> nums, long start, long k) {
        List<Long> sublist = nums.subList((int) start, (int) (start + k));
        Collections.reverse(sublist);
        return nums;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)1l, (long)2l, (long)3l, (long)4l, (long)5l, (long)6l))), (4l), (2l)).equals((new ArrayList<Long>(Arrays.asList((long)1l, (long)2l, (long)3l, (long)4l, (long)6l, (long)5l)))));
    }

}
