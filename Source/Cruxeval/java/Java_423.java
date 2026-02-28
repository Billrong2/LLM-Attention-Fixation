import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_423 {
    public static ArrayList<Long> f(ArrayList<Long> selfie) {
        int lo = selfie.size();
        for (int i = lo - 1; i >= 0; i--) {
            if (selfie.get(i).equals(selfie.get(0))) {
                selfie.remove(selfie.get(lo - 1));
            }
        }
        return selfie;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)4l, (long)2l, (long)5l, (long)1l, (long)3l, (long)2l, (long)6l)))).equals((new ArrayList<Long>(Arrays.asList((long)4l, (long)2l, (long)5l, (long)1l, (long)3l, (long)2l)))));
    }

}
