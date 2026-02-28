import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_184 {
    public static ArrayList<Long> f(ArrayList<Long> digits) {
        Collections.reverse(digits);
        if (digits.size() < 2) {
            return digits;
        }
        for (int i = 0; i < digits.size(); i += 2) {
            Collections.swap(digits, i, i + 1);
        }
        return digits;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)1l, (long)2l)))).equals((new ArrayList<Long>(Arrays.asList((long)1l, (long)2l)))));
    }

}
