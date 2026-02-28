import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_137 {
    public static ArrayList<Long> f(ArrayList<Long> nums) {
        int count = 0;
        while (!nums.isEmpty()) {
            if (count % 2 == 0) {
                nums.remove(nums.size() - 1);
            } else {
                nums.remove(0);
            }
            count++;
        }
        return nums;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)3l, (long)2l, (long)0l, (long)0l, (long)2l, (long)3l)))).equals((new ArrayList<Long>(Arrays.asList()))));
    }

}
