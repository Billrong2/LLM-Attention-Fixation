import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_457 {
    public static ArrayList<Long> f(ArrayList<Long> nums) {
        ArrayList<Long> count = new ArrayList<>();
        for (int i = 0; i < nums.size(); i++) {
            count.add((long)i);
        }
        while (!nums.isEmpty()) {
            nums.remove(nums.size() - 1);
            if (!count.isEmpty()) {
                count.remove(0);
            }
        }
        return nums;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)3l, (long)1l, (long)7l, (long)5l, (long)6l)))).equals((new ArrayList<Long>(Arrays.asList()))));
    }

}
