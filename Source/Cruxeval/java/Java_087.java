import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_087 {
    public static String f(ArrayList<Long> nums) {
        Collections.reverse(nums);
        return nums.stream().map(Object::toString).collect(Collectors.joining());
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)-1l, (long)9l, (long)3l, (long)1l, (long)-2l)))).equals(("-2139-1")));
    }

}
