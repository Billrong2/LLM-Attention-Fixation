import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_439 {
    public static String f(String value) {
        String[] parts = value.split(" ");
        StringBuilder result = new StringBuilder();
        for (int i = 0; i < parts.length; i += 2) {
            result.append(parts[i]);
        }
        return result.toString();
    }
    public static void main(String[] args) {
    assert(f(("coscifysu")).equals(("coscifysu")));
    }

}
