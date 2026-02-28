import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_625 {
    public static long f(String text) {
        int count = 0;
        for (int i = 0; i < text.length(); i++) {
            if (".?!.,".contains(Character.toString(text.charAt(i)))) {
                count++;
            }
        }
        return count;
    }
    public static void main(String[] args) {
    assert(f(("bwiajegrwjd??djoda,?")) == (4l));
    }

}
