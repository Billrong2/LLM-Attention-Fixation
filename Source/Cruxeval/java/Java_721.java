import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_721 {
    public static ArrayList<Long> f(ArrayList<Long> nums) {
        int count = nums.size();
        for (int num = 2; num < count; num++) {
            Collections.sort(nums);
        }
        return nums;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)-6l, (long)-5l, (long)-7l, (long)-8l, (long)2l)))).equals((new ArrayList<Long>(Arrays.asList((long)-8l, (long)-7l, (long)-6l, (long)-5l, (long)2l)))));
    }

}
