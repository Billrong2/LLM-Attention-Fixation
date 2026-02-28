import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_711 {
    public static String f(String text) {
        return text.replace("\n", "\t");
    }
    public static void main(String[] args) {
    assert(f(("apples\n	\npears\n	\nbananas")).equals(("apples			pears			bananas")));
    }

}
