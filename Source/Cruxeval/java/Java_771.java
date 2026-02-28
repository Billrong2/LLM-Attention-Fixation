import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_771 {
    public static ArrayList<Long> f(ArrayList<Long> items) {
        ArrayList<Long> oddPositioned = new ArrayList<>();
        while (items.size() > 0) {
            int position = items.indexOf(Collections.min(items));
            items.remove(position);
            if (position < items.size()) {
                oddPositioned.add(items.remove(position));
            }
        }
        return oddPositioned;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)1l, (long)2l, (long)3l, (long)4l, (long)5l, (long)6l, (long)7l, (long)8l)))).equals((new ArrayList<Long>(Arrays.asList((long)2l, (long)4l, (long)6l, (long)8l)))));
    }

}
