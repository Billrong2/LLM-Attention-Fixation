import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_358 {
    public static String f(String text, String value) {
        List<Integer> indexes = new ArrayList<>();
        for (int i = 0; i < text.length(); i++) {
            if (text.charAt(i) == value.charAt(0) && (i == 0 || text.charAt(i-1) != value.charAt(0))) {
                indexes.add(i);
            }
        }
        if (indexes.size() % 2 == 1) {
            return text;
        }
        return text.substring(indexes.get(0) + 1, indexes.get(indexes.size() - 1));
    }
    public static void main(String[] args) {
    assert(f(("btrburger"), ("b")).equals(("tr")));
    }

}
