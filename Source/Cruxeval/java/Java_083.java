import java.io.*;
import java.lang.reflect.*;
import java.math.*;
import java.security.*;
import java.util.*;
import java.util.stream.*;
import org.javatuples.*;
import org.javatuples.Triplet;
class Java_083 {
    public static String f(String text) {
        Triplet<String, String, String> l = rpartition(text, "0");
        if ("".equals(l.getValue2())) {
            return "-1:-1";
        }
        return String.format("%d:%d", l.getValue0().length(), l.getValue2().indexOf("0") + 1);
    }

    public static Triplet<String, String, String> rpartition(String text, String delimiter) {
        int index = text.lastIndexOf(delimiter);
        if (index == -1) {
            return Triplet.with("", "", text);
        } else {
            return Triplet.with(text.substring(0, index), delimiter, text.substring(index + 1));
        }
    }
    public static void main(String[] args) {
    assert(f(("qq0tt")).equals(("2:0")));
    }

}
