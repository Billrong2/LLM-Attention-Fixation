import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_709 {
    public static String f(String text) {
        String[] myArray = text.split(" ");
        Arrays.sort(myArray, Collections.reverseOrder());
        return String.join(" ", myArray);
    }
    public static void main(String[] args) {
    assert(f(("a loved")).equals(("loved a")));
    }

}
