import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_113 {
    public static String f(String line) {
        int count = 0;
        StringBuilder a = new StringBuilder();
        for (char c : line.toCharArray()) {
            count += 1;
            if (count % 2 == 0) {
                a.append(Character.isLowerCase(c) ? Character.toUpperCase(c) : Character.toLowerCase(c));
            } else {
                a.append(c);
            }
        }
        return a.toString();
    }
    public static void main(String[] args) {
    assert(f(("987yhNSHAshd 93275yrgSgbgSshfbsfB")).equals(("987YhnShAShD 93275yRgsgBgssHfBsFB")));
    }

}
