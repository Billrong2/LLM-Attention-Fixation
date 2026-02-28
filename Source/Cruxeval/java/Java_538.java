import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_538 {
    public static String f(String text, long width) {
        if (text.length() > width) {
            return text.substring(0, (int) width).replace(' ', 'z');
        } else {
            StringBuilder sb = new StringBuilder(text);
            while (sb.length() < width) {
                sb.insert(0, 'z');
                if (sb.length() < width) {
                    sb.append('z');
                }
            }
            return sb.toString();
        }
    }
    public static void main(String[] args) {
    assert(f(("0574"), (9l)).equals(("zzz0574zz")));
    }

}
