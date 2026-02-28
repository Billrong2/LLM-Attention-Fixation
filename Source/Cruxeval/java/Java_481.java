import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_481 {
    public static ArrayList<Long> f(ArrayList<Long> values, long item1, long item2) {
        if (values.get(values.size() - 1) == item2) {
            if (!values.subList(1, values.size()).contains(values.get(0))) {
                values.add(values.get(0));
            }
        } else if (values.get(values.size() - 1) == item1) {
            if (values.get(0) == item2) {
                values.add(values.get(0));
            }
        }
        return values;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)1l, (long)1l))), (2l), (3l)).equals((new ArrayList<Long>(Arrays.asList((long)1l, (long)1l)))));
    }

}
