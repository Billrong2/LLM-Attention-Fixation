import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_064 {
    public static String f(String text, long size) {
        long counter = text.length();
        for (long i = 0; i < size - (size % 2); i++) {
            text = " " + text + " ";
            counter += 2;
            if (counter >= size) {
                return text;
            }
        }
        return text;
    }
    public static void main(String[] args) {
    assert(f(("7"), (10l)).equals(("     7     ")));
    }

}
