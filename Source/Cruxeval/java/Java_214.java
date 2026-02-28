import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_214 {
    public static long f(String sample) {
        int i = -1;
        while (sample.indexOf('/', i+1) != -1) {
            i = sample.indexOf('/', i+1);
        }
        return sample.substring(0, i).lastIndexOf('/');
    }
    public static void main(String[] args) {
    assert(f(("present/here/car%2Fwe")) == (7l));
    }

}
