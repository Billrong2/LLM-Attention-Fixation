import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_499 {
    public static String f(String text, long length, String fillchar) {
        StringBuilder newText = new StringBuilder(text);
        while (newText.length() < length) {
            newText.insert(0, fillchar);
            if (newText.length() < length) {
                newText.append(fillchar);
            }
        }
        return newText.toString();
    }
    public static void main(String[] args) {
    assert(f(("magazine"), (25l), (".")).equals((".........magazine........")));
    }

}
