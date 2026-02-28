import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_148 {
    public static String f(String forest, String animal) {
        int index = forest.indexOf(animal);
        char[] result = forest.toCharArray();
        while (index < forest.length()-1) {
            result[index] = forest.charAt(index+1);
            index++;
        }
        if (index == forest.length()-1) {
            result[index] = '-';
        }
        return new String(result);
    }
    public static void main(String[] args) {
    assert(f(("2imo 12 tfiqr."), ("m")).equals(("2io 12 tfiqr.-")));
    }

}
