import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_544 {
    public static String f(String text) {
        String[] a = text.split("\n");
        List<String> b = new ArrayList<>();
        for (int i = 0; i < a.length; i++) {
            String c = a[i].replace("\t", "    ");
            b.add(c);
        }
        return String.join("\n", b);
    }
    public static void main(String[] args) {
    assert(f(("			tab tab tabulates")).equals(("            tab tab tabulates")));
    }

}
