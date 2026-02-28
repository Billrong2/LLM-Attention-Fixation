import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_722 {
    public static String f(String text) {
        StringBuilder out = new StringBuilder();
        for (int i = 0; i < text.length(); i++) {
            if (Character.isUpperCase(text.charAt(i))) {
                out.append(Character.toLowerCase(text.charAt(i)));
            } else {
                out.append(Character.toUpperCase(text.charAt(i)));
            }
        }
        return out.toString();
    }
    public static void main(String[] args) {
    assert(f((",wPzPppdl/")).equals((",WpZpPPDL/")));
    }

}
