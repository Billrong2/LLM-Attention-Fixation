import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_385 {
    public static ArrayList<Long> f(ArrayList<Long> lst) {
        int i = 0;
        ArrayList<Long> new_list = new ArrayList<>();
        while (i < lst.size()) {
            if (lst.subList(i+1, lst.size()).contains(lst.get(i))) {
                new_list.add(lst.get(i));
                if (new_list.size() == 3) {
                    return new_list;
                }
            }
            i++;
        }
        return new_list;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)0l, (long)2l, (long)1l, (long)2l, (long)6l, (long)2l, (long)6l, (long)3l, (long)0l)))).equals((new ArrayList<Long>(Arrays.asList((long)0l, (long)2l, (long)2l)))));
    }

}
