import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_282 {
    public static long f(String s1, String s2) {
        int position = 1;
        int count = 0;
        while (position > 0) {
            position = s1.indexOf(s2, position);
            count++;
            position++;
        }
        return count;
    }
    public static void main(String[] args) {
    assert(f(("xinyyexyxx"), ("xx")) == (2l));
    }

}
