import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_172 {
    public static ArrayList<Long> f(ArrayList<Long> array) {
        for (int i = 0; i < array.size(); i++) {
            if (array.get(i) < 0) {
                array.remove(i);
                i--; // adjust the index after removal
            }
        }
        return array;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList()))).equals((new ArrayList<Long>(Arrays.asList()))));
    }

}
