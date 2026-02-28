import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_724 {
    public static ArrayList<Long> f(String text, String function) {
        ArrayList<Long> cites = new ArrayList<>();
        cites.add((long)(text.length() - text.indexOf(function) - function.length()));
        for (char c : text.toCharArray()) {
            if (Character.toString(c).equals(function)) {
                cites.add((long)(text.length() - text.indexOf(function) - function.length()));
            }
        }
        return cites;
    }
    public static void main(String[] args) {
    assert(f(("010100"), ("010")).equals((new ArrayList<Long>(Arrays.asList((long)3l)))));
    }

}
