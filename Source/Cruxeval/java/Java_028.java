import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_028 {
    public static boolean f(ArrayList<Long> mylist) {
        ArrayList<Long> revl = new ArrayList<>(mylist);
        Collections.reverse(revl);
        Collections.sort(mylist, Collections.reverseOrder());
        return mylist.equals(revl);
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)5l, (long)8l)))) == (true));
    }

}
