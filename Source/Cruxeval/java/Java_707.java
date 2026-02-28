import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_707 {
    public static String f(String text, long position) {
        int length = text.length();
        int index = (int) (position % (length + 1));
        if (position < 0 || index < 0) {
            index = -1;
        }
        char[] newText = text.toCharArray();
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < newText.length; i++) {
            if (i != index) {
                sb.append(newText[i]);
            }
        }
        return sb.toString();
    }
    public static void main(String[] args) {
    assert(f(("undbs l"), (1l)).equals(("udbs l")));
    }

}
