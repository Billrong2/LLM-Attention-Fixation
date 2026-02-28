import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_048 {
    public static String f(ArrayList<String> names) {
        if (names.isEmpty()) {
            return "";
        }
        String smallest = names.get(0);
        for (int i = 1; i < names.size(); i++) {
            if (names.get(i).compareTo(smallest) < 0) {
                smallest = names.get(i);
            }
        }
        names.remove(smallest);
        return smallest;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<String>(Arrays.asList()))).equals(("")));
    }

}
