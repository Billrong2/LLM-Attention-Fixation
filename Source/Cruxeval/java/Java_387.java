import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_387 {
    public static ArrayList<Long> f(ArrayList<Long> nums, long pos, long value) {
        nums.add((int)pos, (long)value);
        return nums;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)3l, (long)1l, (long)2l))), (2l), (0l)).equals((new ArrayList<Long>(Arrays.asList((long)3l, (long)1l, (long)0l, (long)2l)))));
    }

}
