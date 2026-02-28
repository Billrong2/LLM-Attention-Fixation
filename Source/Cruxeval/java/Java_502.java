import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_502 {
    public static String f(String name) {
        return String.join("*", name.split(" "));
    }
    public static void main(String[] args) {
    assert(f(("Fred Smith")).equals(("Fred*Smith")));
    }

}
