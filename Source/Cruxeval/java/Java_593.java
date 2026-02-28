import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_593 {
    public static ArrayList<Long> f(ArrayList<Long> nums, long n) {
        int pos = nums.size() - 1;
        for (int i = -nums.size(); i < 0; i++) {
            nums.add(pos, nums.get(i));
        }
        return nums;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList())), (14l)).equals((new ArrayList<Long>(Arrays.asList()))));
    }

}
