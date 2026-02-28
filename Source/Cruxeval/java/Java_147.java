import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_147 {
    public static ArrayList<Long> f(ArrayList<Long> nums) {
        int middle = nums.size() / 2;
        return Stream.concat(nums.subList(middle, nums.size()).stream(),
                nums.subList(0, middle).stream())
                .collect(Collectors.toCollection(ArrayList::new));
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)1l, (long)1l, (long)1l)))).equals((new ArrayList<Long>(Arrays.asList((long)1l, (long)1l, (long)1l)))));
    }

}
