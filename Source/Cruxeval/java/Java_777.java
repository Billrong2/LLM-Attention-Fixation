import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_777 {
    public static ArrayList<String> f(ArrayList<String> names, String excluded) {
        for (int i = 0; i < names.size(); i++) {
            if (names.get(i).contains(excluded)) {
                names.set(i, names.get(i).replace(excluded, ""));
            }
        }
        return names;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<String>(Arrays.asList((String)"avc  a .d e"))), ("")).equals((new ArrayList<String>(Arrays.asList((String)"avc  a .d e")))));
    }

}
