import java.io.*;
import java.lang.reflect.*;
import java.math.*;
import java.security.*;
import java.util.*;
import java.util.stream.*;
import org.javatuples.*;
import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_624 {
    public static String f(String text, String character) {
        int charIndex = text.indexOf(character);
        List<Character> result = new ArrayList<>();
        if (charIndex > 0) {
            result.addAll(text.substring(0, charIndex).chars().mapToObj(c -> (char) c).collect(Collectors.toList()));
        }
        result.addAll(character.chars().mapToObj(c -> (char) c).collect(Collectors.toList()));
        result.addAll(text.substring(charIndex + character.length()).chars().mapToObj(c -> (char) c).collect(Collectors.toList()));
        return result.stream().map(String::valueOf).collect(Collectors.joining());
    }
    public static void main(String[] args) {
    assert(f(("llomnrpc"), ("x")).equals(("xllomnrpc")));
    }

}
