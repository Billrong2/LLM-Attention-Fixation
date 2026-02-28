import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_246 {
    public static long f(String haystack, String needle) {
        for (int i = haystack.indexOf(needle); i >= 0; i--) {
            if (haystack.substring(i).equals(needle)) {
                return i;
            }
        }
        return -1;
    }
    public static void main(String[] args) {
    assert(f(("345gerghjehg"), ("345")) == (-1l));
    }

}
