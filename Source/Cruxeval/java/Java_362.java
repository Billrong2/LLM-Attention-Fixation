import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_362 {
    public static String f(String text) {
        for (int i = 0; i < text.length() - 1; i++) {
            if (text.substring(i).toLowerCase().equals(text.substring(i))) {
                return text.substring(i + 1);
            }
        }
        return "";
    }
    public static void main(String[] args) {
    assert(f(("wrazugizoernmgzu")).equals(("razugizoernmgzu")));
    }

}
