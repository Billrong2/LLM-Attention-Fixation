import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_534 {
    public static String f(String sequence, String value) {
        int i = Math.max(sequence.indexOf(value) - sequence.length() / 3, 0);
        StringBuilder result = new StringBuilder();
        for (int j = 0; j < sequence.substring(i).length(); j++) {
            char v = sequence.charAt(i + j);
            if (v == '+') {
                result.append(value);
            } else {
                result.append(v);
            }
        }
        return result.toString();
    }
    public static void main(String[] args) {
    assert(f(("hosu"), ("o")).equals(("hosu")));
    }

}
