import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_573 {
    public static String f(String string, String prefix) {
        if(string.startsWith(prefix)) {
            return string.substring(prefix.length());
        }
        return string;
    }
    public static void main(String[] args) {
    assert(f(("Vipra"), ("via")).equals(("Vipra")));
    }

}
