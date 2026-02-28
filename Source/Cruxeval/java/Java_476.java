import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_476 {
    public static boolean f(String a, String split_on) {
        String[] t = a.split(split_on);
        List<Character> charList = new ArrayList<>();
        for (String i : t) {
            for (char j : i.toCharArray()) {
                charList.add(j);
            }
        }
        if (charList.contains(split_on.charAt(0))) {
            return true;
        } else {
            return false;
        }
    }
    public static void main(String[] args) {
    assert(f(("booty boot-boot bootclass"), ("k")) == (false));
    }

}
