import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_447 {
    public static String f(String text, long tab_size) {
        String res = "";
        text = text.replace("\t", " ".repeat((int)tab_size - 1));
        for (int i = 0; i < text.length(); i++) {
            if (text.charAt(i) == ' ') {
                res += "|";
            } else {
                res += text.charAt(i);
            }
        }
        return res;
    }
    public static void main(String[] args) {
    assert(f(("	a"), (3l)).equals(("||a")));
    }

}
