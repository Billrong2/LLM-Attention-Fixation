import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_406 {
    public static boolean f(String text) {
        char[] ls = text.toCharArray();
        ls[0] = Character.toUpperCase(ls[ls.length - 1]);
        ls[ls.length - 1] = Character.toUpperCase(ls[0]);
        return new String(ls).substring(1).equals(new String(ls).substring(1).toLowerCase());
    }
    public static void main(String[] args) {
    assert(f(("Josh")) == (false));
    }

}
