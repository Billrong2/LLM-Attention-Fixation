import java.io.*;
import java.lang.reflect.*;
import java.math.*;
import java.security.*;
import java.util.*;
import java.util.stream.*;
import org.javatuples.*;
import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_243 {
    public static boolean f(String text, String character) {
        return Character.isLowerCase(character.charAt(0)) && text.equals(text.toLowerCase());
    }
    public static void main(String[] args) {
    assert(f(("abc"), ("e")) == (true));
    }

}
