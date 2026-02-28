import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_171 {
    public static ArrayList<Long> f(ArrayList<Long> nums) {
        int count = nums.size() / 2;
        for (int i = 0; i < count; i++) {
            nums.remove(0);
        }
        return nums;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)3l, (long)4l, (long)1l, (long)2l, (long)3l)))).equals((new ArrayList<Long>(Arrays.asList((long)1l, (long)2l, (long)3l)))));
    }

}
