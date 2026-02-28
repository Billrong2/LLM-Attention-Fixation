import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_179 {
    public static ArrayList<Long> f(ArrayList<Long> nums) {
        ArrayList<Long> numsCopy = new ArrayList<>(nums);
        int count = numsCopy.size();
        for (int i = -count + 1; i < 0; i++) {
            numsCopy.add(0, numsCopy.get(numsCopy.size() + i));
        }
        return numsCopy;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)7l, (long)1l, (long)2l, (long)6l, (long)0l, (long)2l)))).equals((new ArrayList<Long>(Arrays.asList((long)2l, (long)0l, (long)6l, (long)2l, (long)1l, (long)7l, (long)1l, (long)2l, (long)6l, (long)0l, (long)2l)))));
    }

}
