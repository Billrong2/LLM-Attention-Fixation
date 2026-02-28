import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_769 {
    public static String f(String text) {
        char[] textArray = text.toCharArray();
        for (int i = 0; i < textArray.length; i++) {
            textArray[i] = Character.isUpperCase(textArray[i]) ? Character.toLowerCase(textArray[i]) : Character.toUpperCase(textArray[i]);
        }
        return new String(textArray);
    }
    public static void main(String[] args) {
    assert(f(("akA?riu")).equals(("AKa?RIU")));
    }

}
