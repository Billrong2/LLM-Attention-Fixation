import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_111 {
    public static Pair<Long, Long> f(HashMap<String,Long> marks) {
        long highest = 0;
        long lowest = 100;
        for (long value : marks.values()) {
            if (value > highest) {
                highest = value;
            }
            if (value < lowest) {
                lowest = value;
            }
        }
        return new Pair<Long, Long>(highest, lowest);
    }
    public static void main(String[] args) {
    assert(f((new HashMap<String,Long>(Map.of("x", 67l, "v", 89l, "", 4l, "alij", 11l, "kgfsd", 72l, "yafby", 83l)))).equals((Pair.with(89l, 4l))));
    }

}
