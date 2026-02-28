import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_200 {
    public static String f(String text, String value) {
        int length = text.length();
        int index = 0;
        while (length > 0) {
            value = text.charAt(index) + value;
            length--;
            index++;
        }
        return value;
    }
    public static void main(String[] args) {
    assert(f(("jao mt"), ("house")).equals(("tm oajhouse")));
    }

}
