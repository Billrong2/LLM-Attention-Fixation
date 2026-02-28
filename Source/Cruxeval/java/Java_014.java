import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_014 {
    public static String f(String s) {
        char[] arr = s.trim().toCharArray();
        StringBuilder sb = new StringBuilder();
        for (int i = arr.length - 1; i >= 0; i--) {
            sb.append(arr[i]);
        }
        return sb.toString();
    }
    public static void main(String[] args) {
    assert(f(("   OOP   ")).equals(("POO")));
    }

}
