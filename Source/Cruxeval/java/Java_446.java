import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_446 {
    public static ArrayList<Long> f(ArrayList<Long> array) {
        int l = array.size();
        if (l % 2 == 0) {
            array.clear();
        } else {
            Collections.reverse(array);
        }
        return array;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList()))).equals((new ArrayList<Long>(Arrays.asList()))));
    }

}
