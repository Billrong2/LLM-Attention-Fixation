import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_217 {
    public static String f(String string) {
        if(string.matches("[a-zA-Z0-9]+")) {
            return "ascii encoded is allowed for this language";
        }
        return "more than ASCII";
    }
    public static void main(String[] args) {
    assert(f(("Str zahrnuje anglo-ameriæske vasi piscina and kuca!")).equals(("more than ASCII")));
    }

}
