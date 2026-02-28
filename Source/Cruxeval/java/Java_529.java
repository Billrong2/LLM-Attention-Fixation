import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_529 {
    public static ArrayList<Long> f(ArrayList<Long> array) {
        long prev = array.get(0);
        ArrayList<Long> newArray = new ArrayList<>(array);
        for (int i = 1; i < array.size(); i++) {
            if (prev != array.get(i)) {
                newArray.set(i, array.get(i));
            } else {
                newArray.remove(i);
                i--; // Adjust the index after removing an element
            }
            prev = array.get(i);
        }
        return newArray;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)1l, (long)2l, (long)3l)))).equals((new ArrayList<Long>(Arrays.asList((long)1l, (long)2l, (long)3l)))));
    }

}
