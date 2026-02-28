import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_128 {
    public static String f(String text) {
        StringBuilder odd = new StringBuilder();
        StringBuilder even = new StringBuilder();
        for (int i = 0; i < text.length(); i++) {
            char c = text.charAt(i);
            if (i % 2 == 0) {
                even.append(c);
            } else {
                odd.append(c);
            }
        }
        return even.toString() + odd.toString().toLowerCase();
    }
    public static void main(String[] args) {
    assert(f(("Mammoth")).equals(("Mmohamt")));
    }

}
