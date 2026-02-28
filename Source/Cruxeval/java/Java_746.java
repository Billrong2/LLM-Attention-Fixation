import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_746 {
    public static HashMap<String,String> f(HashMap<String,String> dct) {
        HashMap<String, String> result = new HashMap<>();
        for (String value : dct.values()) {
            String item = value.split("\\.")[0] + "@pinc.uk";
            result.put(value, item);
        }
        return result;
    }
    public static void main(String[] args) {
    assert(f((new HashMap<String,String>())).equals((new HashMap<String,String>())));
    }

}
