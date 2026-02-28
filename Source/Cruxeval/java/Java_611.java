import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_611 {
    public static ArrayList<Long> f(ArrayList<Long> nums) {
        Collections.reverse(nums);
        return nums;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)-6l, (long)-2l, (long)1l, (long)-3l, (long)0l, (long)1l)))).equals((new ArrayList<Long>(Arrays.asList((long)1l, (long)0l, (long)-3l, (long)1l, (long)-2l, (long)-6l)))));
    }

}
