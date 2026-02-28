import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_004 {
    public static String f(ArrayList<String> array) {
        StringBuilder s = new StringBuilder(" ");
        s.append(String.join("", array));
        return s.toString();
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<String>(Arrays.asList((String)" ", (String)"  ", (String)"    ", (String)"   ")))).equals(("           ")));
    }

}
