import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_460 {
    public static String f(String text, long amount) {
        int length = text.length();
        String pre_text = "|";
        if (amount >= length) {
            int extra_space = (int) (amount - length);
            pre_text += " ".repeat(extra_space / 2);
            return pre_text + text + pre_text;
        }
        return text;
    }
    public static void main(String[] args) {
    assert(f(("GENERAL NAGOOR"), (5l)).equals(("GENERAL NAGOOR")));
    }

}
