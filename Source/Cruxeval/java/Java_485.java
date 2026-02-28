import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_485 {
    public static String f(String tokens) {
        String[] tokensArray = tokens.split(" ");
        if (tokensArray.length == 2) {
            Collections.reverse(Arrays.asList(tokensArray));
        }
        String result = String.format("%-5s %-5s", tokensArray[0], tokensArray[1]);
        return result;
    }
    public static void main(String[] args) {
    assert(f(("gsd avdropj")).equals(("avdropj gsd  ")));
    }

}
