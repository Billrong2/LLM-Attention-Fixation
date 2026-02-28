import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_167 {
    public static String f(String XAAXX, String s) {
        int count = 0;
        int idx = -1;
        while (XAAXX.indexOf("XXXX", idx + 1) != -1) {
            idx = XAAXX.indexOf("XXXX", idx + 1);
            count += 1;
        }
        String compound = "";
        for (int i = 0; i < count; i++) {
            compound += s.substring(0, 1).toUpperCase() + s.substring(1).toLowerCase();
        }
        return XAAXX.replace("XXXX", compound);
    }
    public static void main(String[] args) {
    assert(f(("aaXXXXbbXXXXccXXXXde"), ("QW")).equals(("aaQwQwQwbbQwQwQwccQwQwQwde")));
    }

}
