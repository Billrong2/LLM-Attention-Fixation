import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_545 {
    public static ArrayList<Long> f(ArrayList<Long> array) {
        ArrayList<Long> result = new ArrayList<>();
        int index = 0;
        while (index < array.size()) {
            result.add(array.remove(array.size() - 1));
            index += 2;
        }
        return result;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)8l, (long)8l, (long)-4l, (long)-9l, (long)2l, (long)8l, (long)-1l, (long)8l)))).equals((new ArrayList<Long>(Arrays.asList((long)8l, (long)-1l, (long)8l)))));
    }

}
