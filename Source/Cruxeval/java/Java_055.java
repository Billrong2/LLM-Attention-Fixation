import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_055 {
    public static ArrayList<Long> f(ArrayList<Long> array) {
        ArrayList<Long> array_2 = new ArrayList<>();
        for (Long i : array) {
            if (i > 0) {
                array_2.add(i);
            }
        }
        Collections.sort(array_2, Collections.reverseOrder());
        return array_2;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)4l, (long)8l, (long)17l, (long)89l, (long)43l, (long)14l)))).equals((new ArrayList<Long>(Arrays.asList((long)89l, (long)43l, (long)17l, (long)14l, (long)8l, (long)4l)))));
    }

}
