import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_109 {
    public static ArrayList<Long> f(ArrayList<Long> nums, long spot, long idx) {
        nums.add((int) spot, (long) idx);
        return nums;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)1l, (long)0l, (long)1l, (long)1l))), (0l), (9l)).equals((new ArrayList<Long>(Arrays.asList((long)9l, (long)1l, (long)0l, (long)1l, (long)1l)))));
    }

}
