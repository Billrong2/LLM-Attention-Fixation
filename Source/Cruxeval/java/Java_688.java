import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_688 {
    public static ArrayList<Long> f(ArrayList<Long> nums) {
        ArrayList<Long> l = new ArrayList<>();
        for (Long i : nums) {
            if (!l.contains(i)) {
                l.add(i);
            }
        }
        return l;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)3l, (long)1l, (long)9l, (long)0l, (long)2l, (long)0l, (long)8l)))).equals((new ArrayList<Long>(Arrays.asList((long)3l, (long)1l, (long)9l, (long)0l, (long)2l, (long)8l)))));
    }

}
