import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_692 {
    public static ArrayList<Long> f(ArrayList<Long> array) {
        ArrayList<Long> a = new ArrayList<>();
        Collections.reverse(array);
        for (int i = 0; i < array.size(); i++) {
            if (array.get(i) != 0) {
                a.add(array.get(i));
            }
        }
        Collections.reverse(a);
        return a;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList()))).equals((new ArrayList<Long>(Arrays.asList()))));
    }

}
