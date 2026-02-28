import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_535 {
    public static boolean f(long n) {
        for (char c : String.valueOf(n).toCharArray()) {
            if (c != '0' && c != '1' && c != '2' && !(c >= '5' && c <= '9')) {
                return false;
            }
        }
        return true;
    }
    public static void main(String[] args) {
    assert(f((1341240312l)) == (false));
    }

}
