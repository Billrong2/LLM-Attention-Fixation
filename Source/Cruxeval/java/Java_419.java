import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_419 {
    public static String f(String text, String value) {
        if (!text.contains(value)) {
            return "";
        }
        return text.substring(0, text.lastIndexOf(value));
    }
    public static void main(String[] args) {
    assert(f(("mmfbifen"), ("i")).equals(("mmfb")));
    }

}
