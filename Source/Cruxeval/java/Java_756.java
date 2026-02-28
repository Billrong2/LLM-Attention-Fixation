import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_756 {
    public static String f(String text) {
        if (text.matches("\\d+") && text.length() > 0) {
            return "integer";
        }
        return "string";
    }
    public static void main(String[] args) {
    assert(f(("")).equals(("string")));
    }

}
