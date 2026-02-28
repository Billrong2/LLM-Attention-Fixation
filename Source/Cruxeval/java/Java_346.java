import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_346 {
    public static boolean f(String filename) {
        String[] parts = filename.split("\\.");
        String suffix = parts[parts.length - 1];
        String f2 = filename + new StringBuilder(suffix).reverse().toString();
        return f2.endsWith(suffix);
    }
    public static void main(String[] args) {
    assert(f(("docs.doc")) == (false));
    }

}
