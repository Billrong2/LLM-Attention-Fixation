import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_278 {
    public static HashMap<Long,ArrayList<Long>> f(ArrayList<Long> array1, ArrayList<Long> array2) {
        HashMap<Long,ArrayList<Long>> result = new HashMap<>();
        for (Long key : array1) {
            result.put(key, new ArrayList<>());
            for (Long el : array2) {
                if (key * 2 > el) {
                    result.get(key).add(el);
                }
            }
        }
        return result;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)0l, (long)132l))), (new ArrayList<Long>(Arrays.asList((long)5l, (long)991l, (long)32l, (long)997l)))).equals((new HashMap<Long,ArrayList<Long>>(Map.of(0l, new ArrayList<Long>(Arrays.asList()), 132l, new ArrayList<Long>(Arrays.asList((long)5l, (long)32l)))))));
    }

}
