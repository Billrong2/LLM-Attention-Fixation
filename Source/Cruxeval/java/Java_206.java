import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_206 {
    public static String f(String a) {
        return String.join(" ", a.trim().split("\\s+"));
    }
    public static void main(String[] args) {
    assert(f((" h e l l o   w o r l d! ")).equals(("h e l l o w o r l d!")));
    }

}
