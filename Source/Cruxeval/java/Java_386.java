import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_386 {
    public static String f(String concat, HashMap<String,String> di) {
        int count = di.size();
        for (int i = 0; i < count; i++) {
            if (di.get(String.valueOf(i)).contains(concat)) {
                di.remove(String.valueOf(i));
            }
        }
        return "Done!";
    }
    public static void main(String[] args) {
    assert(f(("mid"), (new HashMap<String,String>(Map.of("0", "q", "1", "f", "2", "w", "3", "i")))).equals(("Done!")));
    }

}
