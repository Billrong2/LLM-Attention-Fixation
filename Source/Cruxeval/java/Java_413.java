import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_413 {
    public static String f(String s) {
        String part1 = s.length() > 3 ? s.substring(3) : "";
        String part2 = s.length() > 2 ? String.valueOf(s.charAt(2)) : "";
        String part3 = s.length() > 5 ? s.substring(5, Math.min(8, s.length())) : "";
        return part1 + part2 + part3;
    }
    public static void main(String[] args) {
    assert(f(("jbucwc")).equals(("cwcuc")));
    }

}
