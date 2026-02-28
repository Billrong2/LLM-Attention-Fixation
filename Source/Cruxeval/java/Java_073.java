import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_073 {
    public static Pair<Long, Long> f(String row) {
        long ones = 0;
        long zeros = 0;

        for (char c : row.toCharArray()) {
            if (c == '1')
                ones++;
            else if (c == '0')
                zeros++;
        }

        return Pair.with(ones, zeros);
    }
    public static void main(String[] args) {
    assert(f(("100010010")).equals((Pair.with(3l, 6l))));
    }

}
