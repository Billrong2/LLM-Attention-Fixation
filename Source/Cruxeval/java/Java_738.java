import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_738 {
    public static String f(String text, String characters) {
        for (int i = 0; i < characters.length(); i++) {
            text = text.replaceAll("[" + characters.charAt(i) + "]+$", "");
        }
        return text;
    }
    public static void main(String[] args) {
    assert(f(("r;r;r;r;r;r;r;r;r"), ("x.r")).equals(("r;r;r;r;r;r;r;r;")));
    }

}
