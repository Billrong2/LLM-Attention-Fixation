import java.io.*;
import java.lang.reflect.*;
import java.math.*;
import java.security.*;
import java.util.*;
import java.util.stream.*;
import org.javatuples.*;
import java.util.*;

class Java_780 {
    public static String f(ArrayList<Long> ints) {
        int[] counts = new int[301];

        for (long i : ints) {
            counts[(int)i] += 1;
        }

        ArrayList<String> r = new ArrayList<>();
        for (int i = 0; i < counts.length; i++) {
            if (counts[i] >= 3) {
                r.add(String.valueOf(i));
            }
        }
        Arrays.fill(counts, 0);
        return String.join(" ", r);
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)2l, (long)3l, (long)5l, (long)2l, (long)4l, (long)5l, (long)2l, (long)89l)))).equals(("2")));
    }

}
