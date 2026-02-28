import java.io.*;
import java.lang.reflect.*;
import java.math.*;
import java.security.*;
import java.util.*;
import java.util.stream.*;
import java.util.stream.Collectors;
import org.javatuples.*;
import java.util.*;


class Java_411 {
    public static boolean f(String text, Object pref) {
        if (pref instanceof List) {
            List<String> prefList = (List<String>) pref;
            return prefList.stream().map(s -> text.startsWith(s)).reduce(true, (a, b) -> a && b);
        } else {
            return text.startsWith((String) pref);
        }
    }
    public static void main(String[] args) {
    assert(f(("Hello World"), ("W")) == (false));
    }

}
