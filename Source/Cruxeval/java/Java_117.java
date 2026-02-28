import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_117 {
    public static long f(String numbers) {
        for (int i = 0; i < numbers.length(); i++) {
            if (numbers.chars().filter(ch -> ch == '3').count() > 1) {
                return i;
            }
        }
        return -1;
    }
    public static void main(String[] args) {
    assert(f(("23157")) == (-1l));
    }

}
