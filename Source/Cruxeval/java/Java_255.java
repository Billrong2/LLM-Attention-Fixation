import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_255 {
    public static String f(String text, String fill, long size) {
        if (size < 0) {
            size = -size;
        }
        if (text.length() > size) {
            return text.substring(text.length() - (int)size);
        }
        return String.format("%" + size + "s", text).replace(' ', fill.charAt(0));
    }
    public static void main(String[] args) {
    assert(f(("no asw"), ("j"), (1l)).equals(("w")));
    }

}
