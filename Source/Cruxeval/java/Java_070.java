import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_070 {
    public static long f(String x) {
        int a = 0;
        for (String i : x.split(" ")) {
            a += String.format("%0" + (i.length() * 2) + "d", 0).length();
        }
        return a;
    }
    public static void main(String[] args) {
    assert(f(("999893767522480")) == (30l));
    }

}
