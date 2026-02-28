import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_287 {
    public static String f(String name) {
        if (name.equals(name.toLowerCase())) {
            return name.toUpperCase();
        } else {
            return name.toLowerCase();
        }
    }
    public static void main(String[] args) {
    assert(f(("Pinneaple")).equals(("pinneaple")));
    }

}
