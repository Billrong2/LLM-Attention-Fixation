import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_367 {
    public static ArrayList<Long> f(ArrayList<Long> nums, long rmvalue) {
        ArrayList<Long> res = new ArrayList<>(nums);
        while(res.contains(rmvalue)) {
            Long popped = res.remove(res.indexOf(rmvalue));
            if(!popped.equals(rmvalue)) {
                res.add(popped);
            }
        }
        return res;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)6l, (long)2l, (long)1l, (long)1l, (long)4l, (long)1l))), (5l)).equals((new ArrayList<Long>(Arrays.asList((long)6l, (long)2l, (long)1l, (long)1l, (long)4l, (long)1l)))));
    }

}
