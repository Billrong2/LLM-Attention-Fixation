import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_422 {
    public static ArrayList<Long> f(ArrayList<Long> array) {
        ArrayList<Long> new_array = new ArrayList<>(array);
        Collections.reverse(new_array);
        return new_array.stream().map(x -> x * x).collect(Collectors.toCollection(ArrayList::new));
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)1l, (long)2l, (long)1l)))).equals((new ArrayList<Long>(Arrays.asList((long)1l, (long)4l, (long)1l)))));
    }

}
