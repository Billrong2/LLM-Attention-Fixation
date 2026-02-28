import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_512 {
    public static boolean f(String s) {
        return s.length() == s.chars().filter(ch -> ch == '0' || ch == '1').count();
    }
    public static void main(String[] args) {
    assert(f(("102")) == (false));
    }

}
