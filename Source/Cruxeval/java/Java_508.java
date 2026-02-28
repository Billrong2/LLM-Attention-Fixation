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
class Java_508 {
    public static String f(String text, String sep, long maxsplit) {
        String[] splitted = text.split(sep, (int) (maxsplit + 1));
        int length = splitted.length;
        List<String> newSplitted = new ArrayList<>(Arrays.asList(splitted).subList(0, length / 2));
        Collections.reverse(newSplitted);
        newSplitted.addAll(Arrays.asList(Arrays.copyOfRange(splitted, length / 2, length)));
        return String.join(sep, newSplitted);
    }
    public static void main(String[] args) {
    assert(f(("ertubwi"), ("p"), (5l)).equals(("ertubwi")));
    }

}
