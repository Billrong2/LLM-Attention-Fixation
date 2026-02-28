import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;

class Java_400 {
    public static String f(String multi_string) {
        String[] split_string = multi_string.split(" ");
        List<String> ascii_string = new ArrayList<>();
        for (String s : split_string) {
            if (s.matches("\\A\\p{ASCII}*\\z")) {
                ascii_string.add(s);
            }
        }
        return String.join(", ", ascii_string);
    }
    public static void main(String[] args) {
    assert(f(("I am hungry! eat food.")).equals(("I, am, hungry!, eat, food.")));
    }

}
