import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_226 {
    public static ArrayList<Long> f(ArrayList<Long> nums) {
        int size = nums.size();
        for (int i = 0; i < size; i++) {
            if (nums.get(i) % 3 == 0) {
                nums.add(nums.get(i));
            }
        }
        return nums;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)1l, (long)3l)))).equals((new ArrayList<Long>(Arrays.asList((long)1l, (long)3l, (long)3l)))));
    }

}
