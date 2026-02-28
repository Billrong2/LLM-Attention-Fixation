import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_434 {
    public static long f(String string) {
        try {
            return string.lastIndexOf('e');
        } catch (NullPointerException e) {
            return -1;
        }
    }
    public static void main(String[] args) {
    assert(f(("eeuseeeoehasa")) == (8l));
    }

}
