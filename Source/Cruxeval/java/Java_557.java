import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_557 {
    public static String f(String s) {
        int idx = s.lastIndexOf("ar");
        return (idx == -1) ? s : s.substring(0, idx) + ' ' + "ar" + ' ' + s.substring(idx + 2);
    }
    public static void main(String[] args) {
    assert(f(("xxxarmmarxx")).equals(("xxxarmm ar xx")));
    }

}
