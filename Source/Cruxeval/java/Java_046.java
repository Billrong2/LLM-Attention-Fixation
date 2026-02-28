import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_046 {
    public static String f(ArrayList<String> l, String c) {
        return String.join(c, l);
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<String>(Arrays.asList((String)"many", (String)"letters", (String)"asvsz", (String)"hello", (String)"man"))), ("")).equals(("manylettersasvszhelloman")));
    }

}
