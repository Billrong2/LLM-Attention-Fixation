import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_239 {
    public static String f(String text, String froms) {
        return text.replaceAll("^[" + froms + "]+|[" + froms + "]+$", "");
    }
    public static void main(String[] args) {
    assert(f(("0 t 1cos "), ("st 0	\n  ")).equals(("1co")));
    }

}
