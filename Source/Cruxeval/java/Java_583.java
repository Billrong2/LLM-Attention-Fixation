import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_583 {
    public static String f(String text, String ch) {
        String[] lines = text.split("\n");
        StringBuilder result = new StringBuilder();
        for (String line : lines) {
            if (line.length() > 0 && line.charAt(0) == ch.charAt(0)) {
                result.append(line.toLowerCase()).append("\n");
            } else {
                result.append(line.toUpperCase()).append("\n");
            }
        }
        return result.toString().trim();
    }
    public static void main(String[] args) {
    assert(f(("t\nza\na"), ("t")).equals(("t\nZA\nA")));
    }

}
