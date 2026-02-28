import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_507 {
    public static long f(String text, String search) {
        String result = text.toLowerCase();
        return result.indexOf(search.toLowerCase());
    }
    public static void main(String[] args) {
    assert(f(("car hat"), ("car")) == (0l));
    }

}
