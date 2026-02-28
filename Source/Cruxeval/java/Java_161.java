import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_161 {
    public static String f(String text, String value) {
        String[] parts = text.split(value, 2);
        return parts[1] + parts[0];
    }
    public static void main(String[] args) {
    assert(f(("difkj rinpx"), ("k")).equals(("j rinpxdif")));
    }

}
