import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_420 {
    public static boolean f(String text) {
        try {
            return text.matches("[a-zA-Z]+");
        } catch (Exception e) {
            return false;
        }
    }
    public static void main(String[] args) {
    assert(f(("x")) == (true));
    }

}
