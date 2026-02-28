import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_766 {
    public static HashMap<String,Long> f(ArrayList<String> values, long value) {
        HashMap<String, Long> newDict = new HashMap<>();
        int length = values.size();
        for (String val : values) {
            newDict.put(val, value);
        }
        newDict.put(String.join("", values.stream().sorted().toArray(String[]::new)), value * 3);

        return newDict;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<String>(Arrays.asList((String)"0", (String)"3"))), (117l)).equals((new HashMap<String,Long>(Map.of("0", 117l, "3", 117l, "03", 351l)))));
    }

}
