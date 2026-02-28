import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_157 {
    public static long f(String phrase) {
        int ans = 0;
        for (String w : phrase.split(" ")) {
            for (int i = 0; i < w.length(); i++) {
                if (w.charAt(i) == '0') {
                    ans++;
                }
            }
        }
        return ans;
    }
    public static void main(String[] args) {
    assert(f(("aboba 212 has 0 digits")) == (1l));
    }

}
