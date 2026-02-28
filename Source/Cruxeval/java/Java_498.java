import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_498 {
    public static ArrayList<Long> f(ArrayList<Long> nums, long idx, long added) {
        nums.add((int)idx, (long)added);
        return nums;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)2l, (long)2l, (long)2l, (long)3l, (long)3l))), (2l), (3l)).equals((new ArrayList<Long>(Arrays.asList((long)2l, (long)2l, (long)3l, (long)2l, (long)3l, (long)3l)))));
    }

}
