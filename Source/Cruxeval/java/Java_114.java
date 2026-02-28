import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_114 {
    public static ArrayList<String> f(String text, String sep) {
        return new ArrayList<>(Arrays.asList(text.split(sep, -1)));
    }
    public static void main(String[] args) {
    assert(f(("a-.-.b"), ("-.")).equals((new ArrayList<String>(Arrays.asList((String)"a", (String)"", (String)"b")))));
    }

}
