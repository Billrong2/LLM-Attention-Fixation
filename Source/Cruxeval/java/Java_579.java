import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_579 {
    public static String f(String text) {
        if (text.matches("^[A-Z][a-z]*$")) {
            if (text.length() > 1) {
                return text.substring(0, 1).toLowerCase() + text.substring(1);
            }
        } else if (text.matches("^[A-Za-z]+$")) {
            return text.substring(0, 1).toUpperCase() + text.substring(1).toLowerCase();
        }
        return text;
    }
    public static void main(String[] args) {
    assert(f(("")).equals(("")));
    }

}
