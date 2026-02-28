import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_342 {
    public static boolean f(String text) {
        return text.chars().filter(ch -> ch == '-').count() == text.length();
    }
    public static void main(String[] args) {
    assert(f(("---123-4")) == (false));
    }

}
