import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_687 {
    public static String f(String text) {
        ArrayList<String> t = new ArrayList<>(Arrays.asList(text.split("")));
        t.remove(t.size() / 2);
        t.add(text.toLowerCase());
        return String.join(":", t);
    }
    public static void main(String[] args) {
    assert(f(("Rjug nzufE")).equals(("R:j:u:g: :z:u:f:E:rjug nzufe")));
    }

}
