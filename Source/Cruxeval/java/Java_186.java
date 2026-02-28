import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_186 {
    public static String f(String text) {
        return Arrays.stream(text.split(" "))
                .map(String::strip)
                .collect(Collectors.joining(" "));
    }
    public static void main(String[] args) {
    assert(f(("pvtso")).equals(("pvtso")));
    }

}
