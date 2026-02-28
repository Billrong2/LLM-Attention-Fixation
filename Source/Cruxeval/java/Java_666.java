import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_666 {
    public static long f(HashMap<Long,ArrayList<Long>> d1, HashMap<Long,ArrayList<Long>> d2) {
        int mmax = 0;
        for (long k1 : d1.keySet()) {
            int p = d1.get(k1).size() + d2.getOrDefault(k1, new ArrayList<>()).size();
            if (p > mmax) {
                mmax = p;
            }
        }
        return mmax;
    }
    public static void main(String[] args) {
    assert(f((new HashMap<Long,ArrayList<Long>>(Map.of(0l, new ArrayList<Long>(Arrays.asList()), 1l, new ArrayList<Long>(Arrays.asList())))), (new HashMap<Long,ArrayList<Long>>(Map.of(0l, new ArrayList<Long>(Arrays.asList((long)0l, (long)0l, (long)0l, (long)0l)), 2l, new ArrayList<Long>(Arrays.asList((long)2l, (long)2l, (long)2l)))))) == (4l));
    }

}
