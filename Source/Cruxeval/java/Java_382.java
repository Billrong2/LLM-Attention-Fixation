import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;

class Java_382 {
    public static String f(HashMap<Long, String> a) {
        HashMap<Long, String> s = new HashMap<>();
        for (Map.Entry<Long, String> entry : a.entrySet()) {
            s.put(entry.getKey(), entry.getValue());
        }
        StringBuilder sb = new StringBuilder();
        for (Map.Entry<Long, String> entry : s.entrySet()) {
            sb.append("(").append(entry.getKey()).append(", '").append(entry.getValue()).append("') ");
        }
        return sb.toString().trim();    }
    public static void main(String[] args) {
    assert(f((new HashMap<Long,String>(Map.of(15l, "Qltuf", 12l, "Rwrepny")))).equals(("(12, 'Rwrepny') (15, 'Qltuf')")));
    }

}
