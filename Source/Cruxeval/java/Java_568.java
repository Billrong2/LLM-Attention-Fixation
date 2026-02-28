import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_568 {
    public static String f(String num) {
        int letter = 1;
        for (char i : "1234567890".toCharArray()) {
            num = num.replace(String.valueOf(i), "");
            if (num.length() == 0) break;
            num = num.substring(letter) + num.substring(0, letter);
            letter += 1;
            if (letter > num.length()) {
                letter = letter % num.length();
            }
        }
        return num;
    }
    public static void main(String[] args) {
    assert(f(("bwmm7h")).equals(("mhbwm")));
    }

}
