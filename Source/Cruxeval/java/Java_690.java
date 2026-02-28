import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_690 {
    public static String f(String n) {
        if (n.contains(".")) {
            return String.valueOf(Integer.parseInt(n) + 2.5);
        }
        return n;
    }
    public static void main(String[] args) {
    assert(f(("800")).equals(("800")));
    }

}
