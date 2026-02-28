import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_118 {
    public static String f(String text, String chars) {
        int num_applies = 2;
        String extra_chars = "";
        for (int i = 0; i < num_applies; i++) {
            extra_chars += chars;
            text = text.replace(extra_chars, "");
        }
        return text;
    }
    public static void main(String[] args) {
    assert(f(("zbzquiuqnmfkx"), ("mk")).equals(("zbzquiuqnmfkx")));
    }

}
