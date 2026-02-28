import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_119 {
    public static String f(String text) {
        StringBuilder result = new StringBuilder();
        for (int i = 0; i < text.length(); i++) {
            if (i % 2 == 0) {
                result.append(Character.toString(text.charAt(i)).toUpperCase());
            } else {
                result.append(text.charAt(i));
            }
        }
        return result.toString();
    }
    public static void main(String[] args) {
    assert(f(("vsnlygltaw")).equals(("VsNlYgLtAw")));
    }

}
