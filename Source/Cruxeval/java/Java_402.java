import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_402 {
    public static HashMap<Long,Long> f(long n, ArrayList<String> l) {
        HashMap<Long, Long> archive = new HashMap<>();
        for (int i = 0; i < n; i++) {
            archive.clear();
            for (String str : l) {
                long x = Long.parseLong(str);
                archive.put(x + 10, x * 10);
            }
        }
        return archive;
    }
    public static void main(String[] args) {
    assert(f((0l), (new ArrayList<String>(Arrays.asList((String)"aaa", (String)"bbb")))).equals((new HashMap<Long,Long>(Map.of()))));
    }

}
