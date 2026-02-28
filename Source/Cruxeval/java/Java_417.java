import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_417 {
    public static ArrayList<Long> f(ArrayList<Long> lst) {
        Collections.reverse(lst);
        lst.remove(lst.size() - 1);
        Collections.reverse(lst);
        return lst;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)7l, (long)8l, (long)2l, (long)8l)))).equals((new ArrayList<Long>(Arrays.asList((long)8l, (long)2l, (long)8l)))));
    }

}
