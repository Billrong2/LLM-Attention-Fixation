import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.Stream;

class Java_098 {
    public static long f(String s) {
        String[] words = s.split(" ");
        return Arrays.stream(words)
                .map(word -> isTitleCase(word))
                .filter(x -> x)
                .count();
    }

    private static boolean isTitleCase(String word) {
        if (word.length() == 0) {
            return false;
        }

        boolean restLowerCase = word.substring(1).equals(word.substring(1).toLowerCase());
        boolean firstUpperCase = Character.isUpperCase(word.charAt(0));

        return firstUpperCase && restLowerCase;
    }
    public static void main(String[] args) {
    assert(f(("SOME OF THIS Is uknowN!")) == (1l));
    }

}
