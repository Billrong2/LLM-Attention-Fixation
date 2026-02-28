import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_090 {
    public static ArrayList<ArrayList<Long>> f(ArrayList<ArrayList<Long>> array) {
        ArrayList<ArrayList<Long>> returnArr = new ArrayList<>();
        for (ArrayList<Long> a : array) {
            returnArr.add(new ArrayList<>(a));
        }
        return returnArr;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<ArrayList<Long>>(Arrays.asList((ArrayList<Long>)new ArrayList<Long>(Arrays.asList((long)1l, (long)2l, (long)3l)), (ArrayList<Long>)new ArrayList<Long>(Arrays.asList()), (ArrayList<Long>)new ArrayList<Long>(Arrays.asList((long)1l, (long)2l, (long)3l)))))).equals((new ArrayList<ArrayList<Long>>(Arrays.asList((ArrayList<Long>)new ArrayList<Long>(Arrays.asList((long)1l, (long)2l, (long)3l)), (ArrayList<Long>)new ArrayList<Long>(Arrays.asList()), (ArrayList<Long>)new ArrayList<Long>(Arrays.asList((long)1l, (long)2l, (long)3l)))))));
    }

}
