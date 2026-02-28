import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_601 {
    public static String f(String text) {
        int t = 5;
        List<String> tab = new ArrayList<>();
        for (char i : text.toCharArray()) {
            if ("aeiouy".contains(String.valueOf(Character.toLowerCase(i)))) {
                tab.add(String.valueOf(Character.toUpperCase(i)).repeat(t));
            } else {
                tab.add(String.valueOf(i).repeat(t));
            }
        }
        return String.join(" ", tab);
    }
    public static void main(String[] args) {
    assert(f(("csharp")).equals(("ccccc sssss hhhhh AAAAA rrrrr ppppp")));
    }

}
