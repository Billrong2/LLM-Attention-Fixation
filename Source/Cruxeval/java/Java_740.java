import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_740 {
    public static ArrayList<Long> f(ArrayList<Long> plot, long delin) {
        if (plot.contains(delin)) {
            int split = plot.indexOf(delin);
            List<Long> first = plot.subList(0, split);
            List<Long> second = plot.subList(split + 1, plot.size());
            ArrayList<Long> result = new ArrayList<>(first);
            result.addAll(second);
            return result;
        } else {
            return plot;
        }
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)1l, (long)2l, (long)3l, (long)4l))), (3l)).equals((new ArrayList<Long>(Arrays.asList((long)1l, (long)2l, (long)4l)))));
    }

}
