import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_201 {
    public static String f(String text) {
        StringBuilder chars = new StringBuilder();
        for (int i = 0; i < text.length(); i++) {
            char c = text.charAt(i);
            if (Character.isDigit(c)) {
                chars.append(c);
            }
        }
        return new StringBuilder(chars).reverse().toString();
    }
    public static void main(String[] args) {
    assert(f(("--4yrw 251-//4 6p")).equals(("641524")));
    }

}
