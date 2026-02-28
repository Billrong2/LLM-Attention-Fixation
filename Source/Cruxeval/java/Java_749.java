import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_749 {
    public static String f(String text, long width) {
        String result = "";
        String[] lines = text.split("\n");
        for (String l : lines) {
            int padding = (int) width - l.length();
            int padLeft = padding / 2;
            int padRight = padding - padLeft;
            result += " ".repeat(padLeft) + l + " ".repeat(padRight) + "\n";
        }
        return result.substring(0, result.length() - 1); // Remove the very last empty line
    }
    public static void main(String[] args) {
    assert(f(("l\nl"), (2l)).equals(("l \nl ")));
    }

}
