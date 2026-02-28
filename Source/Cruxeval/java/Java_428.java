import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_428 {
    public static ArrayList<Long> f(ArrayList<Long> nums) {
        for (int i = 0; i < nums.size(); i++) {
            if (i % 2 == 0) {
                nums.add(nums.get(i) * nums.get(i + 1));
            }
        }
        return nums;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList()))).equals((new ArrayList<Long>(Arrays.asList()))));
    }

}
