import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_380 {
    public static String f(String text, String delimiter) {
        int index = text.lastIndexOf(delimiter);
        if (index == -1) {
            return text;
        }
        return text.substring(0, index) + text.substring(index + delimiter.length());
    }
    public static void main(String[] args) {
    assert(f(("xxjarczx"), ("x")).equals(("xxjarcz")));
    }

}
