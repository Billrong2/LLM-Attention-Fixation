import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_696 {
    public static long f(String text) {
        int s = 0;
        for (int i = 1; i < text.length(); i++) {
            s += text.substring(0, text.lastIndexOf(text.charAt(i))).length();
        }
        return s;
    }
    public static void main(String[] args) {
    assert(f(("wdj")) == (3l));
    }

}
