import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_551 {
    public static ArrayList<String> f(HashMap<String,ArrayList<String>> data) {
        ArrayList<String> members = new ArrayList<>();
        for (String item : data.keySet()) {
            for (String member : data.get(item)) {
                if (!members.contains(member)) {
                    members.add(member);
                }
            }
        }
        Collections.sort(members);
        return members;
    }
    public static void main(String[] args) {
    assert(f((new HashMap<String,ArrayList<String>>(Map.of("inf", new ArrayList<String>(Arrays.asList((String)"a", (String)"b")), "a", new ArrayList<String>(Arrays.asList((String)"inf", (String)"c")), "d", new ArrayList<String>(Arrays.asList((String)"inf")))))).equals((new ArrayList<String>(Arrays.asList((String)"a", (String)"b", (String)"c", (String)"inf")))));
    }

}
