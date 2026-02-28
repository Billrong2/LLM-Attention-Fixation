import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_034 {
    public static ArrayList<Long> f(ArrayList<Long> nums, long odd1, long odd2) {
        while (nums.contains(odd1)) {
            nums.remove(nums.indexOf(odd1));
        }
        while (nums.contains(odd2)) {
            nums.remove(nums.indexOf(odd2));
        }
        return nums;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)1l, (long)2l, (long)3l, (long)7l, (long)7l, (long)6l, (long)8l, (long)4l, (long)1l, (long)2l, (long)3l, (long)5l, (long)1l, (long)3l, (long)21l, (long)1l, (long)3l))), (3l), (1l)).equals((new ArrayList<Long>(Arrays.asList((long)2l, (long)7l, (long)7l, (long)6l, (long)8l, (long)4l, (long)2l, (long)5l, (long)21l)))));
    }

}
