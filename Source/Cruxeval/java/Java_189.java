import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
import java.util.regex.*;

class Java_189 {
    public static String f(String out, HashMap<String,ArrayList<String>> mapping) {
        for (Map.Entry<String,ArrayList<String>> entry : mapping.entrySet()) {
            if (Pattern.compile("\\{\\w+\\}").matcher(out).find()) {
                ArrayList<String> values = entry.getValue();
                values.set(1, new StringBuilder(values.get(1)).reverse().toString());
            }
        }
        return out;
    }
    public static void main(String[] args) {
    assert(f(("{{{{}}}}"), (new HashMap<String,ArrayList<String>>())).equals(("{{{{}}}}")));
    }

}
