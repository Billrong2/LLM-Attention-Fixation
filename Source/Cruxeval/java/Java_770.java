import java.lang.StringBuilder;
import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;

class Java_770 {
    public static String f(String line, String charStr) {
        int count = (int)line.chars().filter(ch -> ch == charStr.charAt(0)).count();
        StringBuilder lineBuilder = new StringBuilder(line);
        for (int i = count + 1; i > 0; i--) {
            int newLength = lineBuilder.length() + (i / charStr.length());
            int pad = newLength - lineBuilder.length();
            int leftPad = pad / 2;
            int rightPad = pad - leftPad;
            for (int j = 0; j < leftPad; j++) {
                lineBuilder.insert(0, charStr);
            }
            for (int j = 0; j < rightPad; j++) {
                lineBuilder.append(charStr);
            }
        }
        return lineBuilder.toString();
    }
    public static void main(String[] args) {
    assert(f(("$78"), ("$")).equals(("$$78$$")));
    }

}
