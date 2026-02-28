import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_634 {
    public static String f(String input_string) {
        while (input_string.contains("a") || input_string.contains("A")) {
            input_string = input_string.replace('a', 'i').replace('A', 'i');
            input_string = input_string.replace('o', 'u').replace('O', 'U');
            input_string = input_string.replace('i', 'o').replace('I', 'O');
            input_string = input_string.replace('u', 'a').replace('U', 'A');
        }
        return input_string;
    }
    public static void main(String[] args) {
    assert(f(("biec")).equals(("biec")));
    }

}
