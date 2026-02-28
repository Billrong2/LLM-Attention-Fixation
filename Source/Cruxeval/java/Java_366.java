import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_366 {
    public static String f(String string) {
        String tmp = string.toLowerCase();
        for (char c : string.toLowerCase().toCharArray()) {
            int index = tmp.indexOf(c);
            if (index != -1) {
                tmp = tmp.substring(0, index) + tmp.substring(index + 1);
            }
        }
        return tmp;
    }
    public static void main(String[] args) {
    assert(f(("[ Hello ]+ Hello, World!!_ Hi")).equals(("")));
    }

}
