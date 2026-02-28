import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_532 {
    public static ArrayList<ArrayList<Long>> f(long n, ArrayList<Long> array) {
        ArrayList<ArrayList<Long>> finalList = new ArrayList<>();
        finalList.add(new ArrayList<>(array));
        for (int i = 0; i < n; i++) {
            ArrayList<Long> arr = new ArrayList<>(array);
            arr.addAll(finalList.get(finalList.size() - 1));
            finalList.add(arr);
        }
        return finalList;
    }
    public static void main(String[] args) {
    assert(f((1l), (new ArrayList<Long>(Arrays.asList((long)1l, (long)2l, (long)3l)))).equals((new ArrayList<ArrayList<Long>>(Arrays.asList((ArrayList<Long>)new ArrayList<Long>(Arrays.asList((long)1l, (long)2l, (long)3l)), (ArrayList<Long>)new ArrayList<Long>(Arrays.asList((long)1l, (long)2l, (long)3l, (long)1l, (long)2l, (long)3l)))))));
    }

}
