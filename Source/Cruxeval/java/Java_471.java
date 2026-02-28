import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_471 {
    public static long f(String val, String text) {
        char[] textChars = text.toCharArray();
        List<Integer> indices = new ArrayList<>();
        for (int i = 0; i < textChars.length; i++) {
            if (textChars[i] == val.charAt(0)) {
                indices.add(i);
            }
        }
        
        if (indices.isEmpty()) {
            return -1;
        } else {
            return indices.get(0);
        }
    }
    public static void main(String[] args) {
    assert(f(("o"), ("fnmart")) == (-1l));
    }

}
