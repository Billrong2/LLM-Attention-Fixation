import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_250 {
    public static String f(String text) {
        int count = text.length();
        for (int i = -count+1; i < 0; i++) {
            text += text.charAt(text.length()+i);
        }
        return text;
    }
    public static void main(String[] args) {
    assert(f(("wlace A")).equals(("wlace Alc l  ")));
    }

}
