import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_785 {
    public static String f(long n) {
        String streak = "";
        String numString = String.valueOf(n);
        for (char c : numString.toCharArray()) {
            streak += String.format("%-" + (Character.getNumericValue(c) * 2) + "s", c);
        }
        return streak;
    }
    public static void main(String[] args) {
    assert(f((1l)).equals(("1 ")));
    }

}
