import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_058 {
    public static ArrayList<Long> f(ArrayList<Long> nums) {
        int count = nums.size();
        for (int i = 0; i < count; i++) {
            nums.add(nums.get(i % 2));
        }
        return nums;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)-1l, (long)0l, (long)0l, (long)1l, (long)1l)))).equals((new ArrayList<Long>(Arrays.asList((long)-1l, (long)0l, (long)0l, (long)1l, (long)1l, (long)-1l, (long)0l, (long)-1l, (long)0l, (long)-1l)))));
    }

}
