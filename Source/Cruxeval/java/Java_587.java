import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_587 {
    public static HashMap<Long,String> f(ArrayList<Long> nums, String fill) {
        HashMap<Long, String> ans = new HashMap<>();
        for (Long num : nums) {
            ans.put(num, fill);
        }
        return ans;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)0l, (long)1l, (long)1l, (long)2l))), ("abcca")).equals((new HashMap<Long,String>(Map.of(0l, "abcca", 1l, "abcca", 2l, "abcca")))));
    }

}
