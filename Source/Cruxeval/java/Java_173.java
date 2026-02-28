import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_173 {
    public static ArrayList<Long> f(ArrayList<Long> list_x) {
        int item_count = list_x.size();
        ArrayList<Long> new_list = new ArrayList<>();
        for (int i = 0; i < item_count; i++) {
            new_list.add(list_x.remove(list_x.size() - 1));
        }
        return new_list;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)5l, (long)8l, (long)6l, (long)8l, (long)4l)))).equals((new ArrayList<Long>(Arrays.asList((long)4l, (long)8l, (long)6l, (long)8l, (long)5l)))));
    }

}
