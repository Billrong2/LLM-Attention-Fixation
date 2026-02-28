import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_300 {
    public static ArrayList<Long> f(ArrayList<Long> nums) {
        int count = 1;
        for (int i = count; i < nums.size() - 1; i+=2) {
            nums.set(i, Math.max(nums.get(i), nums.get(count - 1)));
            count++;
        }
        return nums;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)1l, (long)2l, (long)3l)))).equals((new ArrayList<Long>(Arrays.asList((long)1l, (long)2l, (long)3l)))));
    }

}
