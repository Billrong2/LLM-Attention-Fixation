import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_567 {
    public static ArrayList<String> f(String s, long n) {
        ArrayList<String> ls = new ArrayList<>(Arrays.asList(s.split(" ")));
        List<String> out = new ArrayList<>();
        while (ls.size() >= n) {
            for(int i=0; i<n; i++){
                out.add(ls.remove(ls.size()-1));
            }
        }
        Collections.reverse(out);
        ls.add(String.join("_", out));
        return ls;
    }
    public static void main(String[] args) {
    assert(f(("one two three four five"), (3l)).equals((new ArrayList<String>(Arrays.asList((String)"one", (String)"two", (String)"three_four_five")))));
    }

}
