import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_327 {
    public static ArrayList<Long> f(ArrayList<Long> lst) {
        ArrayList<Long> newArrayList = new ArrayList<>();
        int i = lst.size() - 1;
        for (int j = 0; j < lst.size(); j++) {
            if (i % 2 == 0) {
                newArrayList.add(-lst.get(i));
            } else {
                newArrayList.add(lst.get(i));
            }
            i--;
        }
        return newArrayList;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)1l, (long)7l, (long)-1l, (long)-3l)))).equals((new ArrayList<Long>(Arrays.asList((long)-3l, (long)1l, (long)7l, (long)-1l)))));
    }

}
