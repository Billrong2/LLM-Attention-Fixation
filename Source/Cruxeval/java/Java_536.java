import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_536 {
    public static long f(String cat) {
        int digits = 0;
        for (char ch : cat.toCharArray()) {
            if (Character.isDigit(ch)) {
                digits++;
            }
        }
        return digits;
    }
    public static void main(String[] args) {
    assert(f(("C24Bxxx982ab")) == (5l));
    }

}
