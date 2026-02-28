import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_521 {
    public static ArrayList<Long> f(ArrayList<Long> nums) {
        long m = Collections.max(nums);
        for (int i = 0; i < m; i++) {
            Collections.reverse(nums);
        }
        return nums;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)43l, (long)0l, (long)4l, (long)77l, (long)5l, (long)2l, (long)0l, (long)9l, (long)77l)))).equals((new ArrayList<Long>(Arrays.asList((long)77l, (long)9l, (long)0l, (long)2l, (long)5l, (long)77l, (long)4l, (long)0l, (long)43l)))));
    }

}
