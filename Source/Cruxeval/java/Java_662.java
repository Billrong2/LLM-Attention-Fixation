import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_662 {
    public static ArrayList<String> f(ArrayList<String> values) {
        ArrayList<String> names = new ArrayList<>(Arrays.asList("Pete", "Linda", "Angela"));
        names.addAll(values);
        Collections.sort(names);
        return names;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<String>(Arrays.asList((String)"Dan", (String)"Joe", (String)"Dusty")))).equals((new ArrayList<String>(Arrays.asList((String)"Angela", (String)"Dan", (String)"Dusty", (String)"Joe", (String)"Linda", (String)"Pete")))));
    }

}
