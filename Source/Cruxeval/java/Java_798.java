import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_798 {
    public static String f(String text, String pre) {
        if (!text.startsWith(pre)) {
            return text;
        }
        return text.substring(pre.length());
    }
    public static void main(String[] args) {
    assert(f(("@hihu@!"), ("@hihu")).equals(("@!")));
    }

}
