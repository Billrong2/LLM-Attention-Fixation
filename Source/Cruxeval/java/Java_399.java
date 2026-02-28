import java.io.*;
import java.lang.reflect.*;
import java.math.*;
import java.security.*;
import java.util.*;
import java.util.stream.*;
import org.javatuples.*;
import java.util.*;

class Java_399 {
    public static String f(String text, String old, String replacement) {
        if (old.length() > 3) {
            return text;
        }
        if (text.contains(old) && !text.contains(" ")) {
            return text.replace(old, replacement.repeat(old.length()));
        }
        while (text.contains(old)) {
            text = text.replace(old, replacement);
        }
        return text;
    }
    public static void main(String[] args) {
    assert(f(("avacado"), ("va"), ("-")).equals(("a--cado")));
    }

}
