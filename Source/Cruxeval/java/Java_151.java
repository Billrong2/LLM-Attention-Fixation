import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_151 {
    public static String f(String text) {
        StringBuilder newText = new StringBuilder();
        for (char c : text.toCharArray()) {
            if (Character.isDigit(c)) {
                if (c == '0') {
                    newText.append('.');
                } else {
                    newText.append(c == '1' ? '0' : c);
                }
            } else {
                newText.append(c);
            }
        }
        return newText.toString().replace('.', '0');
    }
    public static void main(String[] args) {
    assert(f(("697 this is the ultimate 7 address to attack")).equals(("697 this is the ultimate 7 address to attack")));
    }

}
