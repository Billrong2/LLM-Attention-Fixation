import java.io.*;
import java.lang.reflect.*;
import java.math.*;
import java.security.*;
import java.util.*;
import java.util.stream.*;
import org.javatuples.*;
import java.util.*;

class Java_736 {
    public static String f(String text, String insert) {
        Set<Character> whitespaces = new HashSet<>(Arrays.asList('\t', '\r', '\u000B', ' ', '\f', '\n'));
        StringBuilder clean = new StringBuilder();
        for (char ch : text.toCharArray()) {
            if (whitespaces.contains(ch)) {
                clean.append(insert);
            } else {
                clean.append(ch);
            }
        }
        return clean.toString();
    }
    public static void main(String[] args) {
    assert(f(("pi wa"), ("chi")).equals(("pichiwa")));
    }

}
