import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_527 {
    public static String f(String text, String value) {
        StringBuilder sb = new StringBuilder(text);
        while(sb.length() < value.length()) {
            sb.append("?");
        }
        return sb.toString();
    }
    public static void main(String[] args) {
    assert(f(("!?"), ("")).equals(("!?")));
    }

}
