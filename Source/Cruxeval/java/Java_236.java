import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_236 {
    public static String f(ArrayList<String> array) {
        if (array.size() == 1) {
            return String.join("", array);
        }
        ArrayList<String> result = new ArrayList<>(array);
        int i = 0;
        while (i < array.size() - 1) {
            for (int j = 0; j < 2; j++) {
                result.set(i * 2, array.get(i));
                i++;
            }
        }
        return String.join("", result);
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<String>(Arrays.asList((String)"ac8", (String)"qk6", (String)"9wg")))).equals(("ac8qk6qk6")));
    }

}
