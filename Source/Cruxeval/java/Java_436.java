import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_436 {
    public static ArrayList<String> f(String s, ArrayList<Long> characters) {
        ArrayList<String> result = new ArrayList<>();
        for (long character : characters) {
            result.add(s.substring((int) character, (int) character + 1));
        }
        return result;
    }
    public static void main(String[] args) {
    assert(f(("s7 6s 1ss"), (new ArrayList<Long>(Arrays.asList((long)1l, (long)3l, (long)6l, (long)1l, (long)2l)))).equals((new ArrayList<String>(Arrays.asList((String)"7", (String)"6", (String)"1", (String)"7", (String)" ")))));
    }

}
