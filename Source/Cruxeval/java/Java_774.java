import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_774 {
    public static String f(long num, String name) {
        String f_str = "quiz leader = %s, count = %d";
        return String.format(f_str, name, num);
    }
    public static void main(String[] args) {
    assert(f((23l), ("Cornareti")).equals(("quiz leader = Cornareti, count = 23")));
    }

}
