import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_002 {
    public static String f(String text) {
        char[] new_text = text.toCharArray();
        for (char i : new char[] { '+' }) {
            for (int j = 0; j < new_text.length; j++) {
                if (new_text[j] == i) {
                    new_text[j] = ' ';
                    break;
                }
            }
        }
        return new String(new_text).replaceAll(" ", "");
    }
    public static void main(String[] args) {
    assert(f(("hbtofdeiequ")).equals(("hbtofdeiequ")));
    }

}
