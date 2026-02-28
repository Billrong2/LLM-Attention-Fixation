import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_566 {
    public static String f(String string, String code) {
        try {
            byte[] t = string.getBytes(code);
            if (t[t.length - 1] == '\n') {
                t = Arrays.copyOfRange(t, 0, t.length - 1);
            }
            return new String(t, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            return "";
        }
    }
    public static void main(String[] args) {
    assert(f(("towaru"), ("UTF-8")).equals(("towaru")));
    }

}
