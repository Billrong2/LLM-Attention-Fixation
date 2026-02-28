import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_115 {
    public static String f(String text) {
        StringBuilder res = new StringBuilder();
        byte[] bytes = text.getBytes();
        for (byte ch : bytes) {
            if (ch == 61) {
                break;
            }
            if (ch != 0) {
                res.append(String.format("%d; ", ch));
            }
        }
        return "b'" + res.toString() + "'";
    }
    public static void main(String[] args) {
    assert(f(("os||agx5")).equals(("b'111; 115; 124; 124; 97; 103; 120; 53; '")));
    }

}
