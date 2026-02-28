import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_183 {
    public static ArrayList<String> f(String text) {
        String[] ls = text.split(" ");
        List<String> lines = Arrays.asList(String.join(" ", Arrays.asList(ls).subList(0, ls.length/3)).split("\n"));
        ArrayList<String> res = new ArrayList<>();
        for (int i = 0; i < 2; i++) {
            List<String> ln = Arrays.asList(ls).subList(1, ls.length / 3);
            if (3 * i + 1 < ln.size()) {
                res.add(String.join(" ", ln.subList(3 * i, 3 * (i + 1))));
            }
        }
        ArrayList<String> result = new ArrayList<>();
        result.addAll(lines);
        result.addAll(res);
        return result;
    }
    public static void main(String[] args) {
    assert(f(("echo hello!!! nice!")).equals((new ArrayList<String>(Arrays.asList((String)"echo")))));
    }

}
