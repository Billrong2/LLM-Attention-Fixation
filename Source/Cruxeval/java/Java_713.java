import java.io.*;
import java.lang.reflect.*;
import java.math.*;
import java.security.*;
import java.util.*;
import java.util.stream.*;
import org.javatuples.*;
import java.util.*;
import java.util.stream.*;

class Java_713 {
    public static boolean f(String text, String character) {
        if (text.contains(character)) {
            String[] parts = text.split(character);
            List<String> cleanedParts = Arrays.stream(parts)
                    .map(String::trim)
                    .filter(part -> !part.isEmpty())
                    .collect(Collectors.toList());
            if (cleanedParts.size() > 1) {
                return true;
            }
        }
        return false;
    }
    public static void main(String[] args) {
    assert(f(("only one line"), (" ")) == (true));
    }

}
