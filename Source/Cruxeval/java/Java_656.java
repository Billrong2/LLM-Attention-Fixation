import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_656 {
    public static String f(ArrayList<String> letters) {
        HashSet<String> a = new HashSet<>();
        for (int i = 0; i < letters.size(); i++) {
            if (a.contains(letters.get(i))) {
                return "no";
            }
            a.add(letters.get(i));
        }
        return "yes";
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<String>(Arrays.asList((String)"b", (String)"i", (String)"r", (String)"o", (String)"s", (String)"j", (String)"v", (String)"p")))).equals(("yes")));
    }

}
