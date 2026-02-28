import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_452 {
    public static long f(String text) {
        int counter = 0;
        for (int i = 0; i < text.length(); i++) {
            if (Character.isLetter(text.charAt(i))) {
                counter++;
            }
        }
        return counter;
    }
    public static void main(String[] args) {
    assert(f(("l000*")) == (1l));
    }

}
