import java.io.*;
import java.lang.reflect.*;
import java.math.*;
import java.security.*;
import java.util.*;
import java.util.stream.*;
import org.javatuples.*;
import java.util.*;

class Java_305 {
    public static String f(String text, String character) {
        int length = text.length();
        int index = -1;
        for (int i = 0; i < length; i++) {
            if (text.charAt(i) == character.charAt(0)) {
                index = i;
            }
        }
        if (index == -1) {
            index = length / 2;
        }
        char[] new_text = text.toCharArray();
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < length; i++) {
            if (i != index) {
                sb.append(new_text[i]);
            }
        }
        return sb.toString();
    }
    public static void main(String[] args) {
    assert(f(("o horseto"), ("r")).equals(("o hoseto")));
    }

}
