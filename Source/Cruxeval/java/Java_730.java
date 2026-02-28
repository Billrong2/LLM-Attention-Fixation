import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_730 {
    public static long f(String text) {
        int m = 0;
        int cnt = 0;
        for (String i : text.split(" ")) {
            if (i.length() > m) {
                cnt++;
                m = i.length();
            }
        }
        return cnt;
    }
    public static void main(String[] args) {
    assert(f(("wys silak v5 e4fi rotbi fwj 78 wigf t8s lcl")) == (2l));
    }

}
