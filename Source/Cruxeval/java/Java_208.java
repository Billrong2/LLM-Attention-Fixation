import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_208 {
    public static ArrayList<String> f(ArrayList<String> items) {
        ArrayList<String> result = new ArrayList<>();
        for (String item : items) {
            for (char d : item.toCharArray()) {
                if (!Character.isDigit(d)) {
                    result.add(String.valueOf(d));
                }
            }
        }
        return result;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<String>(Arrays.asList((String)"123", (String)"cat", (String)"d dee")))).equals((new ArrayList<String>(Arrays.asList((String)"c", (String)"a", (String)"t", (String)"d", (String)" ", (String)"d", (String)"e", (String)"e")))));
    }

}
