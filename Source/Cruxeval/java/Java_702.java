import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_702 {
    public static ArrayList<Long> f(ArrayList<Long> nums) {
        int count = nums.size();
        for (int i = nums.size() - 1; i >= 0; i--) {
            nums.add(i, nums.remove(0));
        }
        return nums;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)0l, (long)-5l, (long)-4l)))).equals((new ArrayList<Long>(Arrays.asList((long)-4l, (long)-5l, (long)0l)))));
    }

}
