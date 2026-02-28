import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_180 {
    public static ArrayList<Long> f(ArrayList<Long> nums) {
        long a = -1;
        ArrayList<Long> b = new ArrayList<>(nums.subList(1, nums.size()));
        while (a <= b.get(0)) {
            nums.remove(b.get(0));
            a = 0;
            b.remove(0);
        }
        return nums;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)-1l, (long)5l, (long)3l, (long)-2l, (long)-6l, (long)8l, (long)8l)))).equals((new ArrayList<Long>(Arrays.asList((long)-1l, (long)-2l, (long)-6l, (long)8l, (long)8l)))));
    }

}
