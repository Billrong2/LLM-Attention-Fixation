import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_035 {
    public static ArrayList<Long> f(String pattern, ArrayList<String> items) {
        ArrayList<Long> result = new ArrayList<>();
        for (String text : items) {
            long pos = text.lastIndexOf(pattern);
            if (pos >= 0) {
                result.add(pos);
            }
        }
        return result;
    }
    public static void main(String[] args) {
    assert(f((" B "), (new ArrayList<String>(Arrays.asList((String)" bBb ", (String)" BaB ", (String)" bB", (String)" bBbB ", (String)" bbb")))).equals((new ArrayList<Long>(Arrays.asList()))));
    }

}
