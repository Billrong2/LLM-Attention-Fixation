import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_216 {
    public static long f(String letters) {
        int count = 0;
        for (int i = 0; i < letters.length(); i++) {
            if (Character.isDigit(letters.charAt(i))) {
                count++;
            }
        }
        return count;
    }
    public static void main(String[] args) {
    assert(f(("dp ef1 gh2")) == (2l));
    }

}
