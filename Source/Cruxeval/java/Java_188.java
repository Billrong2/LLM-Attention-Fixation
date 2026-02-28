import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_188 {
    public static ArrayList<String> f(ArrayList<String> strings) {
        ArrayList<String> new_strings = new ArrayList<>();
        for (String string : strings) {
            if (string.startsWith("a") || string.startsWith("p")) {
                new_strings.add(string.substring(0, Math.min(string.length(), 2)));
            }
        }
        return new_strings;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<String>(Arrays.asList((String)"a", (String)"b", (String)"car", (String)"d")))).equals((new ArrayList<String>(Arrays.asList((String)"a")))));
    }

}
