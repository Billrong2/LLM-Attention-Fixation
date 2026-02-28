import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_575 {
    public static long f(ArrayList<Long> nums, long val) {
        long sum = 0;
        ArrayList<Long> newList = new ArrayList<>();
        for (long i : nums) {
            for (int j = 0; j < val; j++) {
                newList.add(i);
            }
        }
        
        for (long num : newList) {
            sum += num;
        }
        
        return sum;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)10l, (long)4l))), (3l)) == (42l));
    }

}
