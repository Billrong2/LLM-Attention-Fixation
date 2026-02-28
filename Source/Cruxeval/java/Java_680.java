import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_680 {
    public static String f(String text) {
        String letters = "";
        for (int i = 0; i < text.length(); i++) {
            if (Character.isLetterOrDigit(text.charAt(i))) {
                letters += text.charAt(i);
            }
        }
        return letters;
    }
    public static void main(String[] args) {
    assert(f(("we@32r71g72ug94=(823658*!@324")).equals(("we32r71g72ug94823658324")));
    }

}
