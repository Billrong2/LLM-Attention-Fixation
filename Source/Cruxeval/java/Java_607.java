import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_607 {
    public static boolean f(String text) {
        for (String i : new String[]{".", "!", "?"}) {
            if (text.endsWith(i)) {
                return true;
            }
        }
        return false;
    }
    public static void main(String[] args) {
    assert(f((". C.")) == (true));
    }

}
