import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_473 {
    public static String f(String text, String value) {
        List<Integer> indexes = new ArrayList<>();
        for (int i = 0; i < text.length(); i++) {
            if (text.charAt(i) == value.charAt(0)) {
                indexes.add(i);
            }
        }
        char[] newText = text.toCharArray();
        for (int i : indexes) {
            newText[i] = '\0';
        }
        StringBuilder sb = new StringBuilder();
        for (char c : newText) {
            if (c != '\0') {
                sb.append(c);
            }
        }
        return sb.toString();
    }
    public static void main(String[] args) {
    assert(f(("scedvtvotkwqfoqn"), ("o")).equals(("scedvtvtkwqfqn")));
    }

}
