import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_675 {
    public static ArrayList<Long> f(ArrayList<Long> nums, long sort_count) {
        Collections.sort(nums);
        return new ArrayList<>(nums.subList(0, (int)sort_count));
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)1l, (long)2l, (long)2l, (long)3l, (long)4l, (long)5l))), (1l)).equals((new ArrayList<Long>(Arrays.asList((long)1l)))));
    }

}
