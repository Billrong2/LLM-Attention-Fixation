import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_067 {
    public static String f(long num1, long num2, long num3) {
        List<Long> nums = new ArrayList<>(Arrays.asList(num1, num2, num3));
        Collections.sort(nums);

        return String.format("%d,%d,%d", nums.get(0), nums.get(1), nums.get(2));
    }
    public static void main(String[] args) {
    assert(f((6l), (8l), (8l)).equals(("6,8,8")));
    }

}
