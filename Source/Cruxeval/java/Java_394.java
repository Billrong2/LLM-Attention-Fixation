import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_394 {
    public static long f(String text) {
        String[] lines = text.split("\\r?\\n");
        int i = 0;
        for (String line : lines) {
            if (line.isEmpty()) {
                return i;
            }
            i++;
        }
        return -1;
    }
    public static void main(String[] args) {
    assert(f(("2 m2 \n\nbike")) == (1l));
    }

}
