import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_038 {
    public static String f(String string) {
        string = string.toLowerCase();
        char[] chars = string.toCharArray();
        boolean foundSpace = true;
        for (int i = 0; i < chars.length; i++) {
            if (Character.isLetter(chars[i])) {
                if (foundSpace) {
                    chars[i] = Character.toUpperCase(chars[i]);
                    foundSpace = false;
                }
            } else {
                foundSpace = true;
            }
        }
        return new String(chars).replace(" ", "");
    }
    public static void main(String[] args) {
    assert(f(("1oE-err bzz-bmm")).equals(("1Oe-ErrBzz-Bmm")));
    }

}
