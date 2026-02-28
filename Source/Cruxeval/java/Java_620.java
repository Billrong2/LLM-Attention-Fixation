import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_620 {
    public static String f(String x) {
        List<String> characters = Arrays.asList(x.split(""));
        Collections.reverse(characters);
        return String.join(" ", characters);
    }
    public static void main(String[] args) {
    assert(f(("lert dna ndqmxohi3")).equals(("3 i h o x m q d n   a n d   t r e l")));
    }

}
