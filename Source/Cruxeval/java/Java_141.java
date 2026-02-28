import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
import java.util.function.*;
class Java_141 {
    public static ArrayList<Long> f(ArrayList<String> li) {
        ArrayList<Long> output = new ArrayList<>();
        for (String i : li) {
            output.add((long) Collections.frequency(li, i));
        }
        return output;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<String>(Arrays.asList((String)"k", (String)"x", (String)"c", (String)"x", (String)"x", (String)"b", (String)"l", (String)"f", (String)"r", (String)"n", (String)"g")))).equals((new ArrayList<Long>(Arrays.asList((long)1l, (long)3l, (long)1l, (long)3l, (long)3l, (long)1l, (long)1l, (long)1l, (long)1l, (long)1l, (long)1l)))));
    }

}
