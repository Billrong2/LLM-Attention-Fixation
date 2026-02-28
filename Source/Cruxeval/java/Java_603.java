import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_603 {
    public static String f(String sentences) {
        String[] splitSentences = sentences.split("\\.");
        for (String sentence : splitSentences) {
            if (!sentence.matches("\\d+")) {
                return "not oscillating";
            }
        }
        return "oscillating";
    }
    public static void main(String[] args) {
    assert(f(("not numbers")).equals(("not oscillating")));
    }

}
