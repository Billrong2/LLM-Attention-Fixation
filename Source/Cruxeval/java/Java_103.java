import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_103 {
    public static String f(String s) {
        return s.chars()
                .mapToObj(Character::toString)
                .map(String::toLowerCase)
                .collect(Collectors.joining());
    }
    public static void main(String[] args) {
    assert(f(("abcDEFGhIJ")).equals(("abcdefghij")));
    }

}
