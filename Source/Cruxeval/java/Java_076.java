import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_076 {
    public static ArrayList<Long> f(ArrayList<Long> nums) {
        nums.removeIf(y -> y <= 0);
        if (nums.size() <= 3) {
            return nums;
        }
        Collections.reverse(nums);
        int half = nums.size() / 2;
        ArrayList<Long> result = new ArrayList<>(nums.subList(0, half));
        for (int i = 0; i < 5; i++) {
            result.add(0L);
        }
        result.addAll(nums.subList(half, nums.size()));
        return result;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)10l, (long)3l, (long)2l, (long)2l, (long)6l, (long)0l)))).equals((new ArrayList<Long>(Arrays.asList((long)6l, (long)2l, (long)0l, (long)0l, (long)0l, (long)0l, (long)0l, (long)2l, (long)3l, (long)10l)))));
    }

}
