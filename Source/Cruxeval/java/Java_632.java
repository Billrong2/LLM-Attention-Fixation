import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_632 {
    public static ArrayList<Long> f(ArrayList<Long> lst) {
        for (int i = lst.size() - 1; i > 0; i--) {
            for (int j = 0; j < i; j++) {
                if (lst.get(j) > lst.get(j + 1)) {
                    Collections.swap(lst, j, j + 1);
                }
            }
        }
        return lst;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)63l, (long)0l, (long)1l, (long)5l, (long)9l, (long)87l, (long)0l, (long)7l, (long)25l, (long)4l)))).equals((new ArrayList<Long>(Arrays.asList((long)0l, (long)0l, (long)1l, (long)4l, (long)5l, (long)7l, (long)9l, (long)25l, (long)63l, (long)87l)))));
    }

}
