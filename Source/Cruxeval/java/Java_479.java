import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_479 {
    public static ArrayList<Long> f(ArrayList<Long> nums, long pop1, long pop2) {
        nums.remove((int)pop1 - 1);
        nums.remove((int)pop2 - 1);
        return nums;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)1l, (long)5l, (long)2l, (long)3l, (long)6l))), (2l), (4l)).equals((new ArrayList<Long>(Arrays.asList((long)1l, (long)2l, (long)3l)))));
    }

}
