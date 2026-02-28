import java.io.*;
import java.lang.reflect.*;
import java.math.*;
import java.security.*;
import java.util.*;
import java.util.stream.*;
import org.javatuples.*;
import java.util.*;

class Java_234 {
    public static long f(String text, String character) {
        int position = text.length();
        if (text.contains(character)) {
            position = text.indexOf(character);
            if (position > 1) {
                position = (position + 1) % text.length();
            }
        }
        return position;
    }
    public static void main(String[] args) {
    assert(f(("wduhzxlfk"), ("w")) == (0l));
    }

}
