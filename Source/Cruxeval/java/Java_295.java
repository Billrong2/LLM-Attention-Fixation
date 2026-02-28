import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_295 {
    public static ArrayList<String> f(ArrayList<String> fruits) {
        if (fruits.get(fruits.size() - 1).equals(fruits.get(0))) {
            ArrayList<String> result = new ArrayList<>();
            result.add("no");
            return result;
        } else {
            fruits.remove(0);
            fruits.remove(fruits.size() - 1);
            fruits.remove(0);
            fruits.remove(fruits.size() - 1);
            return fruits;
        }
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<String>(Arrays.asList((String)"apple", (String)"apple", (String)"pear", (String)"banana", (String)"pear", (String)"orange", (String)"orange")))).equals((new ArrayList<String>(Arrays.asList((String)"pear", (String)"banana", (String)"pear")))));
    }

}
