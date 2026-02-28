import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_698 {
    public static String f(String text) {
        return text.chars()
                   .mapToObj(c -> (char) c)
                   .filter(c -> c != ')')
                   .map(String::valueOf)
                   .collect(Collectors.joining());
    }
    public static void main(String[] args) {
    assert(f(("(((((((((((d))))))))).))))(((((")).equals(("(((((((((((d.(((((")));
    }

}
