import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_146 {
    public static ArrayList<Long> f(long single_digit) {
        ArrayList<Long> result = new ArrayList<>();
        for (int c = 1; c < 11; c++) {
            if (c != single_digit) {
                result.add((long) c);
            }
        }
        return result;
    }
    public static void main(String[] args) {
    assert(f((5l)).equals((new ArrayList<Long>(Arrays.asList((long)1l, (long)2l, (long)3l, (long)4l, (long)6l, (long)7l, (long)8l, (long)9l, (long)10l)))));
    }

}
