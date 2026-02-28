import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_106 {
    public static ArrayList<Long> f(ArrayList<Long> nums) {
        int count = nums.size();
        for (int i = 0; i < count; i++) {
            nums.add(i, nums.get(i)*2);
        }
        return nums;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)2l, (long)8l, (long)-2l, (long)9l, (long)3l, (long)3l)))).equals((new ArrayList<Long>(Arrays.asList((long)4l, (long)4l, (long)4l, (long)4l, (long)4l, (long)4l, (long)2l, (long)8l, (long)-2l, (long)9l, (long)3l, (long)3l)))));
    }

}
