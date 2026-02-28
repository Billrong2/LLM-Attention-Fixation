import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_758 {
    public static boolean f(ArrayList<Long> nums) {
        List<Long> reversedNums = new ArrayList<>(nums);
        Collections.reverse(reversedNums);
        return nums.equals(reversedNums);
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)0l, (long)3l, (long)6l, (long)2l)))) == (false));
    }

}
