import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_298 {
    public static String f(String text) {
        char[] new_text = text.toCharArray();
        for (int i = 0; i < new_text.length; i++) {
            char character = new_text[i];
            char new_character = Character.isUpperCase(character) ? Character.toLowerCase(character) : Character.toUpperCase(character);
            new_text[i] = new_character;
        }
        return new String(new_text);
    }
    public static void main(String[] args) {
    assert(f(("dst vavf n dmv dfvm gamcu dgcvb.")).equals(("DST VAVF N DMV DFVM GAMCU DGCVB.")));
    }

}
