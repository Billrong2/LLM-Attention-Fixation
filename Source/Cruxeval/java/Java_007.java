import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_007 {
    public static ArrayList<Long> f(ArrayList<Long> list) {
        ArrayList<Long> original = new ArrayList<>(list);
        while (list.size() > 1) {
            list.remove(list.size() - 1);
            for (int i = 0; i < list.size(); i++) {
                list.remove(i);
            }
        }
        list = new ArrayList<>(original);
        if (!list.isEmpty()) {
            list.remove(0);
        }
        return list;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList()))).equals((new ArrayList<Long>(Arrays.asList()))));
    }

}
