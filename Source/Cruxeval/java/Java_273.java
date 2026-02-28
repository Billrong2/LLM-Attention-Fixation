import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_273 {
    public static String f(String name) {
        String new_name = "";
        name = new StringBuilder(name).reverse().toString();
        for (int i = 0; i < name.length(); i++) {
            char n = name.charAt(i);
            if (n != '.' && new_name.chars().filter(ch -> ch == '.').count() < 2) {
                new_name = n + new_name;
            } else {
                break;
            }
        }
        return new_name;
    }
    public static void main(String[] args) {
    assert(f((".NET")).equals(("NET")));
    }

}
