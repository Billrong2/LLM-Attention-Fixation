import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_716 {
    public static ArrayList<Long> f(ArrayList<Long> nums) {
        int count = nums.size();
        while (nums.size() > (count/2)) {
            nums.clear();
        }
        return nums;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)2l, (long)1l, (long)2l, (long)3l, (long)1l, (long)6l, (long)3l, (long)8l)))).equals((new ArrayList<Long>(Arrays.asList()))));
    }

}
