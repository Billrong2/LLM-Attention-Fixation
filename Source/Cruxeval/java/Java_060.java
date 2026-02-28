import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_060 {
    public static String f(String doc) {
        for (char x : doc.toCharArray()) {
            if (Character.isLetter(x)) {
                return Character.toString(Character.toUpperCase(x));
            }
        }
        return "-";
    }
    public static void main(String[] args) {
    assert(f(("raruwa")).equals(("R")));
    }

}
