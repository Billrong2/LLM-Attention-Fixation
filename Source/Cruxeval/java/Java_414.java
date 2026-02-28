import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_414 {
    public static HashMap<String,ArrayList<String>> f(HashMap<String,ArrayList<String>> d) {
        HashMap<String, ArrayList<String>> dCopy = new HashMap<>(d);
        for (Map.Entry<String, ArrayList<String>> entry : dCopy.entrySet()) {
            ArrayList<String> value = entry.getValue();
            for (int i = 0; i < value.size(); i++) {
                value.set(i, value.get(i).toUpperCase());
            }
        }
        return dCopy;
    }
    public static void main(String[] args) {
    assert(f((new HashMap<String,ArrayList<String>>(Map.of("X", new ArrayList<String>(Arrays.asList((String)"x", (String)"y")))))).equals((new HashMap<String,ArrayList<String>>(Map.of("X", new ArrayList<String>(Arrays.asList((String)"X", (String)"Y")))))));
    }

}
