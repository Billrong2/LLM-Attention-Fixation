import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_266 {
    public static ArrayList<Long> f(ArrayList<Long> nums) {
        for (int i = nums.size() - 1; i >= 0; i--) {
            if (nums.get(i) % 2 == 1) {
                nums.add(i+1, nums.get(i));
            }
        }
        return nums;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)2l, (long)3l, (long)4l, (long)6l, (long)-2l)))).equals((new ArrayList<Long>(Arrays.asList((long)2l, (long)3l, (long)3l, (long)4l, (long)6l, (long)-2l)))));
    }

}
