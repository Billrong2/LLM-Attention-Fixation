import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_735 {
    public static String f(String sentence) {
        if (sentence.isEmpty()) {
            return "";
        }
        sentence = sentence.replace("(", "");
        sentence = sentence.replace(")", "");
        return sentence.substring(0, 1).toUpperCase() + sentence.substring(1).toLowerCase().replaceAll(" ", "");
    }
    public static void main(String[] args) {
    assert(f(("(A (b B))")).equals(("Abb")));
    }

}
