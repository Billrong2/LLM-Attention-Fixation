import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_465 {
    public static HashMap<String,String> f(ArrayList<String> seq, String value) {
        HashMap<String, String> roles = new HashMap<>();
        for (String s : seq) {
            roles.put(s, "north");
        }
        if (!value.isEmpty()) {
            for (String key : value.split(", ")) {
                roles.put(key.trim(), "");
            }
        }
        return roles;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<String>(Arrays.asList((String)"wise king", (String)"young king"))), ("")).equals((new HashMap<String,String>(Map.of("wise king", "north", "young king", "north")))));
    }

}
