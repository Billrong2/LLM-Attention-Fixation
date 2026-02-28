import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_759 {
    public static ArrayList<Long> f(String text, String sub) {
        ArrayList<Long> index = new ArrayList<>();
        long starting = 0;
        while (starting != -1) {
            starting = text.indexOf(sub, (int) starting);
            if (starting != -1) {
                index.add(starting);
                starting += sub.length();
            }
        }
        return index;
    }
    public static void main(String[] args) {
    assert(f(("egmdartoa"), ("good")).equals((new ArrayList<Long>(Arrays.asList()))));
    }

}
