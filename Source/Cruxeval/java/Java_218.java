import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_218 {
    public static String f(String string, String sep) {
        int cnt = string.split(sep, -1).length - 1;
        return new StringBuilder(string + sep).reverse().toString().repeat(cnt);
    }
    public static void main(String[] args) {
    assert(f(("caabcfcabfc"), ("ab")).equals(("bacfbacfcbaacbacfbacfcbaac")));
    }

}
