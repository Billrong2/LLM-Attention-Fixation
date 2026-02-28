import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_091 {
    public static ArrayList<String> f(String s) {
        ArrayList<String> result = new ArrayList<>();
        for (int i = 0; i < s.length(); i++) {
            String character = String.valueOf(s.charAt(i));
            if (!result.contains(character)) {
                result.add(character);
            }
        }
        return result;
    }
    public static void main(String[] args) {
    assert(f(("12ab23xy")).equals((new ArrayList<String>(Arrays.asList((String)"1", (String)"2", (String)"a", (String)"b", (String)"3", (String)"x", (String)"y")))));
    }

}
