import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_549 {
    public static ArrayList<ArrayList<Long>> f(ArrayList<ArrayList<Long>> matrix) {
        Collections.reverse(matrix);
        ArrayList<ArrayList<Long>> result = new ArrayList<>();
        for (ArrayList<Long> primary : matrix) {
            Collections.sort(primary, Collections.reverseOrder());
            result.add(primary);
        }
        return result;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<ArrayList<Long>>(Arrays.asList((ArrayList<Long>)new ArrayList<Long>(Arrays.asList((long)1l, (long)1l, (long)1l, (long)1l)))))).equals((new ArrayList<ArrayList<Long>>(Arrays.asList((ArrayList<Long>)new ArrayList<Long>(Arrays.asList((long)1l, (long)1l, (long)1l, (long)1l)))))));
    }

}
