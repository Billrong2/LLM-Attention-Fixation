import java.io.*;
import java.lang.reflect.*;
import java.math.*;
import java.security.*;
import java.util.*;
import java.util.stream.*;
import org.javatuples.*;
import java.util.*;

class Java_715 {
    public static boolean f(String text, String character) {
        return text.chars().filter(c -> c == character.charAt(0)).count() % 2 != 0;
    }
    public static void main(String[] args) {
    assert(f(("abababac"), ("a")) == (false));
    }

}
