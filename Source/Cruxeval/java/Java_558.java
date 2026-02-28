import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_558 {
    public static boolean f(ArrayList<Long> nums, ArrayList<Long> mos) {
        for (long num : mos) {
            nums.remove(nums.indexOf(num));
        }
        Collections.sort(nums);
        for (long num : mos) {
            nums.add(num);
        }
        for (int i = 0; i < nums.size() - 1; i++) {
            if (nums.get(i) > nums.get(i + 1)) {
                return false;
            }
        }
        return true;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)3l, (long)1l, (long)2l, (long)1l, (long)4l, (long)1l))), (new ArrayList<Long>(Arrays.asList((long)1l)))) == (false));
    }

}
