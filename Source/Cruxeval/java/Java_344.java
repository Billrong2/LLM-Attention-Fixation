import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_344 {
    public static ArrayList<Long> f(ArrayList<Long> lst) {
        ArrayList<Long> new_list = new ArrayList<>(lst);
        Collections.sort(new_list);
        Collections.reverse(new_list);
        return lst;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)6l, (long)4l, (long)2l, (long)8l, (long)15l)))).equals((new ArrayList<Long>(Arrays.asList((long)6l, (long)4l, (long)2l, (long)8l, (long)15l)))));
    }

}
