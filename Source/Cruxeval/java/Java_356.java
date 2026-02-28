import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_356 {
    public static ArrayList<Long> f(ArrayList<Long> array, long num) {
        boolean reverse = false;
        if (num < 0) {
            reverse = true;
            num *= -1;
        }
        Collections.reverse(array);
        ArrayList<Long> newArray = new ArrayList<>();
        for (long i = 0; i < num; i++) {
            newArray.addAll(array);
        }
        if (reverse) {
            Collections.reverse(newArray);
        }
        return newArray;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)1l, (long)2l))), (1l)).equals((new ArrayList<Long>(Arrays.asList((long)2l, (long)1l)))));
    }

}
