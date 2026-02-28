import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_368 {
    public static String f(String string, ArrayList<Long> numbers) {
        ArrayList<String> arr = new ArrayList<>();
        for (long num : numbers) {
            arr.add(String.format("%0" + num + "d", Long.parseLong(string)));
        }
        return String.join(" ", arr);
    }
    public static void main(String[] args) {
    assert(f(("4327"), (new ArrayList<Long>(Arrays.asList((long)2l, (long)8l, (long)9l, (long)2l, (long)7l, (long)1l)))).equals(("4327 00004327 000004327 4327 0004327 4327")));
    }

}
