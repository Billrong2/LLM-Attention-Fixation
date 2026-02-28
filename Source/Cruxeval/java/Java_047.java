import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_047 {
    public static boolean f(String text) {
        int length = text.length();
        int half = length / 2;
        byte[] encode = text.substring(0, half).getBytes();
        if (text.substring(half).equals(new String(encode))) {
            return true;
        } else {
            return false;
        }
    }
    public static void main(String[] args) {
    assert(f(("bbbbr")) == (false));
    }

}
