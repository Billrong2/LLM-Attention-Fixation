import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;

class Java_174 {
    public static ArrayList<Long> f(ArrayList<Long> lst) {
        if (lst.size() > 3) {
            Collections.reverse(lst.subList(1, 4));
        } else if (lst.size() > 1) {
            Collections.reverse(lst.subList(1, lst.size()));
        }
        return lst;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)1l, (long)2l, (long)3l)))).equals((new ArrayList<Long>(Arrays.asList((long)1l, (long)3l, (long)2l)))));
    }

}
