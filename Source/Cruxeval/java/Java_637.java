import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_637 {
    public static String f(String text) {
        String[] words = text.split(" ");
        for (String word : words) {
            if (!word.matches("\\d+")) {
                return "no";
            }
        }
        return "yes";
    }
    public static void main(String[] args) {
    assert(f(("03625163633 d")).equals(("no")));
    }

}
