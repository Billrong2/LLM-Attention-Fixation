import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_204 {
    public static ArrayList<String> f(String name) {
        ArrayList<String> result = new ArrayList<>();
        result.add(String.valueOf(name.charAt(0)));
        result.add(String.valueOf(name.charAt(1)).substring(0, 1));
        return result;
    }
    public static void main(String[] args) {
    assert(f(("master. ")).equals((new ArrayList<String>(Arrays.asList((String)"m", (String)"a")))));
    }

}
