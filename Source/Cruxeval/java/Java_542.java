import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_542 {
    public static ArrayList<String> f(String test, String sep, long maxsplit) {
        String[] result;
        try {
            result = test.split(sep, (int) maxsplit);
        } catch (Exception e) {
            result = test.split(" ");
        }
        return new ArrayList<>(Arrays.asList(result));
    }
    public static void main(String[] args) {
    assert(f(("ab cd"), ("x"), (2l)).equals((new ArrayList<String>(Arrays.asList((String)"ab cd")))));
    }

}
