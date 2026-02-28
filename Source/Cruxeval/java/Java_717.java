import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_717 {
    public static String f(String text) {
        int k = 0;
        int l = text.length() - 1;
        while (!Character.isLetter(text.charAt(l))) {
            l--;
        }
        while (!Character.isLetter(text.charAt(k))) {
            k++;
        }
        if (k != 0 || l != text.length() - 1) {
            return text.substring(k, l+1);
        } else {
            return String.valueOf(text.charAt(0));
        }
    }
    public static void main(String[] args) {
    assert(f(("timetable, 2mil")).equals(("t")));
    }

}
