import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_205 {
    public static String f(String a) {
        for (int i = 0; i < 10; i++) {
            for (int j = 0; j < a.length(); j++) {
                if (a.charAt(j) != '#') {
                    a = a.substring(j);
                    break;
                }
            }
        }
        while (a.charAt(a.length() - 1) == '#') {
            a = a.substring(0, a.length() - 1);
        }
        return a;
    }
    public static void main(String[] args) {
    assert(f(("##fiu##nk#he###wumun##")).equals(("fiu##nk#he###wumun")));
    }

}
