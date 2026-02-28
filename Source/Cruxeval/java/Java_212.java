import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_212 {
    public static ArrayList<Long> f(ArrayList<Long> nums) {
        for (int i = 0; i < nums.size() - 1; i++) {
            Collections.reverse(nums);
        }
        return nums;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)1l, (long)-9l, (long)7l, (long)2l, (long)6l, (long)-3l, (long)3l)))).equals((new ArrayList<Long>(Arrays.asList((long)1l, (long)-9l, (long)7l, (long)2l, (long)6l, (long)-3l, (long)3l)))));
    }

}
