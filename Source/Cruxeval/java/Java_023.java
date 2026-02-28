import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_023 {
    public static String f(String text, String chars) {
        if (!chars.isEmpty()) {
            text = text.replaceAll("[" + chars + "]+$", "");
        } else {
            text = text.trim();
        }
        if (text.isEmpty()) {
            return "-";
        }
        return text;
    }
    public static void main(String[] args) {
    assert(f(("new-medium-performing-application - XQuery 2.2"), ("0123456789-")).equals(("new-medium-performing-application - XQuery 2.")));
    }

}
