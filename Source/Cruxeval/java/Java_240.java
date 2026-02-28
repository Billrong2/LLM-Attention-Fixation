import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_240 {
    public static String f(float float_number) {
        String number = String.valueOf(float_number);
        int dot = number.indexOf('.');
        if (dot != -1) {
            return number.substring(0, dot) + '.' + String.format("%-2s", number.substring(dot + 1)).replace(' ', '0');
        }
        return number + ".00";
    }
    public static void main(String[] args) {
    assert(f((3.121f)).equals(("3.121")));
    }

}
