import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_031 {
    public static long f(String string) {
        int upper = 0;
        for (int i = 0; i < string.length(); i++) {
            char c = string.charAt(i);
            if (Character.isUpperCase(c)) {
                upper++;
            }
        }
        return upper * (upper % 2 == 0 ? 2 : 1);
    }
    public static void main(String[] args) {
    assert(f(("PoIOarTvpoead")) == (8l));
    }

}
