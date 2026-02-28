import java.io.*;
import java.lang.reflect.*;
import java.math.*;
import java.security.*;
import java.util.*;
import java.util.stream.*;
import org.javatuples.*;
import org.javatuples.Pair;
import java.util.*;


class Java_000 {
    public static ArrayList<Pair<Long, Long>> f(ArrayList<Long> nums) {
        ArrayList<Pair<Long, Long>> output = new ArrayList<>();
        for (Long n : nums) {
            output.add(new Pair<>((long) Collections.frequency(nums, n), n));
        }
        output.sort((a, b) -> b.getValue0().compareTo(a.getValue0()));
        return output;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)1l, (long)1l, (long)3l, (long)1l, (long)3l, (long)1l)))).equals((new ArrayList<Pair<Long, Long>>(Arrays.asList((Pair<Long, Long>)Pair.with(4l, 1l), (Pair<Long, Long>)Pair.with(4l, 1l), (Pair<Long, Long>)Pair.with(4l, 1l), (Pair<Long, Long>)Pair.with(4l, 1l), (Pair<Long, Long>)Pair.with(2l, 3l), (Pair<Long, Long>)Pair.with(2l, 3l))))));
    }

}
