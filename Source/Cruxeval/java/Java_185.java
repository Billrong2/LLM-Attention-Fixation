import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_185 {
    public static ArrayList<Long> f(ArrayList<Long> L) {
        int N = L.size();
        for (int k = 1; k <= N/2; k++) {
            int i = k - 1;
            int j = N - k;
            while (i < j) {
                // swap elements:
                long temp = L.get(i);
                L.set(i, L.get(j));
                L.set(j, temp);
                // update i, j:
                i++;
                j--;
            }
        }
        return L;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)16l, (long)14l, (long)12l, (long)7l, (long)9l, (long)11l)))).equals((new ArrayList<Long>(Arrays.asList((long)11l, (long)14l, (long)7l, (long)12l, (long)9l, (long)16l)))));
    }

}
