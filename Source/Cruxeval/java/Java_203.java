import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_203 {
    public static HashMap<String,String> f(HashMap<String,String> d) {
        d.clear();
        return d;
    }
    public static void main(String[] args) {
    assert(f((new HashMap<String,String>(Map.of("a", "3", "b", "-1", "c", "Dum")))).equals((new HashMap<String,String>())));
    }

}
