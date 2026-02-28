import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_377 {
    public static String f(String text) {
        return String.join(", ", text.split("\\r?\\n"));
    }
    public static void main(String[] args) {
    assert(f(("BYE\nNO\nWAY")).equals(("BYE, NO, WAY")));
    }

}
