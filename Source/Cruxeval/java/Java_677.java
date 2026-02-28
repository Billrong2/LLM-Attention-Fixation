import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_677 {
    public static String f(String text, long length) {
        length = length < 0 ? -length : length;
        String output = "";
        for (int idx = 0; idx < length; idx++) {
            if (text.charAt(idx % text.length()) != ' ') {
                output += text.charAt(idx % text.length());
            } else {
                break;
            }
        }
        return output;
    }
    public static void main(String[] args) {
    assert(f(("I got 1 and 0."), (5l)).equals(("I")));
    }

}
