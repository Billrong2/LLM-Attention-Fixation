import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_425 {
    public static ArrayList<String> f(String a) {
        a = a.replace("/", ":");
        String[] z = a.split(":");
        ArrayList<String> result = new ArrayList<>();
        result.add(z[0]);
        result.add(":");
        result.add(z[1]);
        return result;
    }
    public static void main(String[] args) {
    assert(f(("/CL44     ")).equals((new ArrayList<String>(Arrays.asList((String)"", (String)":", (String)"CL44     ")))));
    }

}
