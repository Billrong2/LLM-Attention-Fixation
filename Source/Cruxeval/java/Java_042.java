import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_042 {
    public static ArrayList<Long> f(ArrayList<Long> nums) {
        nums.clear();
        for(int i = 0; i < nums.size(); i++) {
            nums.set(i, nums.get(i) * 2);
        }
        return nums;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)4l, (long)3l, (long)2l, (long)1l, (long)2l, (long)-1l, (long)4l, (long)2l)))).equals((new ArrayList<Long>(Arrays.asList()))));
    }

}
