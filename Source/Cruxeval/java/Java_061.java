import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_061 {
    public static String f(String text) {
        String[] texts = text.split(" ");
        if (texts.length > 0) {
            List<String> xtexts = Arrays.stream(texts)
                    .filter(t -> t.matches("\\p{ASCII}") && !Arrays.asList("nada", "0").contains(t))
                    .collect(Collectors.toList());
            return xtexts.stream().max(Comparator.comparing(String::length)).orElse("nada");
        }
        return "nada";
    }
    public static void main(String[] args) {
    assert(f(("")).equals(("nada")));
    }

}
