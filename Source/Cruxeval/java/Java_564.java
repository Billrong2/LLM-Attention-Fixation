import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_564 {
    public static ArrayList<Long> f(ArrayList<ArrayList<Long>> lists) {
        lists.get(1).clear();
        lists.get(2).addAll(lists.get(1));
        return lists.get(0);
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<ArrayList<Long>>(Arrays.asList((ArrayList<Long>)new ArrayList<Long>(Arrays.asList((long)395l, (long)666l, (long)7l, (long)4l)), (ArrayList<Long>)new ArrayList<Long>(Arrays.asList()), (ArrayList<Long>)new ArrayList<Long>(Arrays.asList((long)4223l, (long)111l)))))).equals((new ArrayList<Long>(Arrays.asList((long)395l, (long)666l, (long)7l, (long)4l)))));
    }

}
