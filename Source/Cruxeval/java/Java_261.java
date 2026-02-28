import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_261 {
    public static Pair<ArrayList<Long>, ArrayList<Long>> f(ArrayList<Long> nums, long target) {
        ArrayList<Long> lows = new ArrayList<>();
        ArrayList<Long> higgs = new ArrayList<>();
        for (long i : nums) {
            if (i < target) {
                lows.add(i);
            } else {
                higgs.add(i);
            }
        }
        lows.clear();
        return new Pair<>(lows, higgs);
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)12l, (long)516l, (long)5l, (long)2l, (long)3l, (long)214l, (long)51l))), (5l)).equals((Pair.with(new ArrayList<Long>(Arrays.asList()), new ArrayList<Long>(Arrays.asList((long)12l, (long)516l, (long)5l, (long)214l, (long)51l))))));
    }

}
