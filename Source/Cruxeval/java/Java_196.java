import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;

class Java_196 {
    public static String f(String text) {
        text = text.replace(" x", " x.");
        if (text.equals(toTitleCase(text))) {
            return "correct";
        }
        text = text.replace(" x.", " x");
        return "mixed";
    }

    private static String toTitleCase(String text) {
        if (text == null || text.isEmpty()) {
            return text;
        }

        StringBuilder converted = new StringBuilder();

        boolean convertNext = true;
        for (char ch : text.toCharArray()) {
            if (Character.isSpaceChar(ch)) {
                convertNext = true;
            } else if (convertNext) {
                ch = Character.toUpperCase(ch);
                convertNext = false;
            } else {
                ch = Character.toLowerCase(ch);
            }
            converted.append(ch);
        }

        return converted.toString();
    }
    public static void main(String[] args) {
    assert(f(("398 Is A Poor Year To Sow")).equals(("correct")));
    }

}
