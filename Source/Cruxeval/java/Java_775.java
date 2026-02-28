import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_775 {
    public static ArrayList<Long> f(ArrayList<Long> nums) {
        int count = nums.size();
        for (int i = 0; i < count / 2; i++) {
            long temp = nums.get(i);
            nums.set(i, nums.get(count - i - 1));
            nums.set(count - i - 1, temp);
        }
        return nums;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)2l, (long)6l, (long)1l, (long)3l, (long)1l)))).equals((new ArrayList<Long>(Arrays.asList((long)1l, (long)3l, (long)1l, (long)6l, (long)2l)))));
    }

}
