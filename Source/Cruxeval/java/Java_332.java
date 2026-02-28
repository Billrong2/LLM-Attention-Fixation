import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_332 {
    public static ArrayList<Long> f(ArrayList<Long> nums) {
        int count = nums.size();
        if(count == 0) {
            nums.clear();
            int n = Math.toIntExact(nums.remove(nums.size() - 1));
            for (int i = 0; i < n; i++) {
                nums.add(0L);
            }
        } else if (count % 2 == 0) {
            nums.clear();
        } else {
            nums.subList(0, count / 2).clear();
        }
        return nums;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)-6l, (long)-2l, (long)1l, (long)-3l, (long)0l, (long)1l)))).equals((new ArrayList<Long>(Arrays.asList()))));
    }

}
