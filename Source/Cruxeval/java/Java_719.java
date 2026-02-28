import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_719 {
    public static String f(String code) {
        String[] lines = code.split("]");
        List<String> result = new ArrayList<>();
        int level = 0;
        for (String line : lines) {
            result.add(line.charAt(0) + " " + "  ".repeat(level) + line.substring(1));
            level += line.chars().filter(ch -> ch == '{').count() - line.chars().filter(ch -> ch == '}').count();
        }
        return String.join("\n", result);
    }
    public static void main(String[] args) {
    assert(f(("if (x) {y = 1;} else {z = 1;}")).equals(("i f (x) {y = 1;} else {z = 1;}")));
    }

}
