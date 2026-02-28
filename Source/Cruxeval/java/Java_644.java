import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_644 {
    public static ArrayList<Long> f(ArrayList<Long> nums, long pos) {
        if (pos % 2 == 1) {
            Collections.reverse(nums.subList(0, nums.size() - 1));
        } else {
            Collections.reverse(nums);
        }
        return nums;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)6l, (long)1l))), (3l)).equals((new ArrayList<Long>(Arrays.asList((long)6l, (long)1l)))));
    }

}
