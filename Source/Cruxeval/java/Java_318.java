import java.io.*;
import java.lang.reflect.*;
import java.math.*;
import java.security.*;
import java.util.*;
import java.util.stream.*;
import org.javatuples.*;
import java.util.*;

class Java_318 {
    public static int f(String value, String character) {
        int total = 0;
        for (char c : value.toCharArray()) {
            if (c == character.charAt(0) || c == Character.toLowerCase(character.charAt(0))) {
                total++;
            }
        }
        return total;
    }
    public static void main(String[] args) {
    assert(f(("234rtccde"), ("e")) == (1l));
    }

}
