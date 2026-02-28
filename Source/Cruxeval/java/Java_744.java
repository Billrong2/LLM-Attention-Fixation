import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_744 {
    public static String f(String text, String new_ending) {
        StringBuilder result = new StringBuilder(text);
        result.append(new_ending);
        return result.toString();
    }
    public static void main(String[] args) {
    assert(f(("jro"), ("wdlp")).equals(("jrowdlp")));
    }

}
