import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_202 {
    public static ArrayList<Long> f(ArrayList<Long> array, ArrayList<Long> lst) {
        array.addAll(lst);
        array.stream().filter(e -> e % 2 == 0);
        ArrayList<Long> result = new ArrayList<>();
        for (Long e : array) {
            if (e >= 10) {
                result.add(e);
            }
        }
        return result;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)2l, (long)15l))), (new ArrayList<Long>(Arrays.asList((long)15l, (long)1l)))).equals((new ArrayList<Long>(Arrays.asList((long)15l, (long)15l)))));
    }

}
