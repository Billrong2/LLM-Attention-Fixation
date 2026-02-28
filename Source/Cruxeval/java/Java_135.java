import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;

class Java_135 {
    public static ArrayList<String> f() {
        LinkedHashMap<String, List<Pair<String, String>>> d = new LinkedHashMap<>();
        d.put("Russia", Arrays.asList(new Pair<>("Moscow", "Russia"), new Pair<>("Vladivostok", "Russia")));
        d.put("Kazakhstan", Arrays.asList(new Pair<>("Astana", "Kazakhstan")));
        return new ArrayList<>(d.keySet());
    }
    public static void main(String[] args) {
    assert(f().equals((new ArrayList<String>(Arrays.asList((String)"Russia", (String)"Kazakhstan")))));
    }

}
