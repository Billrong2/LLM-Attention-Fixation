import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_133 {
    public static ArrayList<Long> f(ArrayList<Long> nums, ArrayList<Long> elements) {
        ArrayList<Long> result = new ArrayList<>();
        for (int i = 0; i < elements.size(); i++) {
            result.add(nums.remove(nums.size()-1));
        }
        return nums;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)7l, (long)1l, (long)2l, (long)6l, (long)0l, (long)2l))), (new ArrayList<Long>(Arrays.asList((long)9l, (long)0l, (long)3l)))).equals((new ArrayList<Long>(Arrays.asList((long)7l, (long)1l, (long)2l)))));
    }

}
