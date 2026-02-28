import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_541 {
    public static boolean f(String text) {
        return String.join("", Arrays.asList(text.split(""))).isBlank();
    }
    public static void main(String[] args) {
    assert(f((" 	  　")) == (true));
    }

}
