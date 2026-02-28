import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_008 {
    public static String f(String string, long encryption) {
        if (encryption == 0) {
            return string;
        } else {
            return new String(string.toUpperCase().chars().map(c -> {
                if (c >= 'A' && c <= 'Z') {
                    return 'A' + (c - 'A' + 13) % 26;
                } else if (c >= 'a' && c <= 'z') {
                    return 'a' + (c - 'a' + 13) % 26;
                } else {
                    return c;
                }
            }).toArray(), 0, string.length());
        }
    }
    public static void main(String[] args) {
    assert(f(("UppEr"), (0l)).equals(("UppEr")));
    }

}
