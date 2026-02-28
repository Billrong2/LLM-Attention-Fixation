import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_657 {
    public static String f(String text) {
        for (char punct : new char[]{'!', '.', '?', ',', ':', ';'}) {
            if (text.chars().filter(c -> c == punct).count() > 1) {
                return "no";
            }
            if (text.endsWith(String.valueOf(punct))) {
                return "no";
            }
        }
        return text.substring(0, 1).toUpperCase() + text.substring(1);
    }
    public static void main(String[] args) {
    assert(f(("djhasghasgdha")).equals(("Djhasghasgdha")));
    }

}
