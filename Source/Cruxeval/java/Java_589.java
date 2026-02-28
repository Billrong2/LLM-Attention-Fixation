import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_589 {
    public static ArrayList<Long> f(ArrayList<Long> num) {
        num.add(num.get(num.size() - 1));
        return num;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)-70l, (long)20l, (long)9l, (long)1l)))).equals((new ArrayList<Long>(Arrays.asList((long)-70l, (long)20l, (long)9l, (long)1l, (long)1l)))));
    }

}
