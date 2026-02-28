import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;

class Java_272 {
    public static ArrayList<Long> f(ArrayList<Long> base_list, ArrayList<Long> nums) {
        base_list.addAll(nums);
        ArrayList<Long> res = new ArrayList<>(base_list);
        for (int i = -nums.size(); i < 0; i++) {
            res.add(res.get(res.size() + i));
        }
        return res;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)9l, (long)7l, (long)5l, (long)3l, (long)1l))), (new ArrayList<Long>(Arrays.asList((long)2l, (long)4l, (long)6l, (long)8l, (long)0l)))).equals((new ArrayList<Long>(Arrays.asList((long)9l, (long)7l, (long)5l, (long)3l, (long)1l, (long)2l, (long)4l, (long)6l, (long)8l, (long)0l, (long)2l, (long)6l, (long)0l, (long)6l, (long)6l)))));
    }

}
