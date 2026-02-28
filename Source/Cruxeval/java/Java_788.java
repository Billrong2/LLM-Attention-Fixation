import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_788 {
    public static String f(String text, String suffix) {
        if(suffix.startsWith("/")) {
            return text + suffix.substring(1);
        }
        return text;
    }
    public static void main(String[] args) {
    assert(f(("hello.txt"), ("/")).equals(("hello.txt")));
    }

}
