import java.io.*;
import java.lang.reflect.*;
import java.math.*;
import java.security.*;
import java.util.*;
import java.util.stream.*;
import org.javatuples.*;
import java.util.*;

class Java_299 {
    public static String f(String text, String character) {
        if (!text.endsWith(character)) {
            return f(character + text, character);
        }
        return text;
    }
    public static void main(String[] args) {
    assert(f(("staovk"), ("k")).equals(("staovk")));
    }

}
