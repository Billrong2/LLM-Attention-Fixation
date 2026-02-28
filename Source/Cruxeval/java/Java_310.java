import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_310 {
    public static String f(ArrayList<String> strands) {
        ArrayList<String> subs = new ArrayList<>(strands);
        for (int i = 0; i < subs.size(); i++) {
            String j = subs.get(i);
            for (int k = 0; k < j.length() / 2; k++) {
                subs.set(i, j.charAt(j.length() - 1) + j.substring(1, j.length() - 1) + j.charAt(0));
            }
        }
        return String.join("", subs);
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<String>(Arrays.asList((String)"__", (String)"1", (String)".", (String)"0", (String)"r0", (String)"__", (String)"a_j", (String)"6", (String)"__", (String)"6")))).equals(("__1.00r__j_a6__6")));
    }

}
