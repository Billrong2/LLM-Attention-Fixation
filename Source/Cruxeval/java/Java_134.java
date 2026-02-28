import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_134 {
    public static String f(long n) {
        long t = 0;
        String b = "";
        String nStr = Long.toString(n);
        List<Integer> digits = new ArrayList<>();
        for (int i = 0; i < nStr.length(); i++) {
            digits.add(Character.getNumericValue(nStr.charAt(i)));
        }
        
        for (int d : digits) {
            if (d == 0) {
                t++;
            } else {
                break;
            }
        }
        
        for (int i = 0; i < t; i++) {
            b += "1" + "0" + "4";
        }
        b += nStr;
        
        return b;
    }
    public static void main(String[] args) {
    assert(f((372359l)).equals(("372359")));
    }

}
