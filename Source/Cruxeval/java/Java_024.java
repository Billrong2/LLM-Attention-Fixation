import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_024 {
    public static ArrayList<Long> f(ArrayList<Long> nums, long i) {
        nums.remove((int)i);
        return nums;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)35l, (long)45l, (long)3l, (long)61l, (long)39l, (long)27l, (long)47l))), (0l)).equals((new ArrayList<Long>(Arrays.asList((long)45l, (long)3l, (long)61l, (long)39l, (long)27l, (long)47l)))));
    }

}
