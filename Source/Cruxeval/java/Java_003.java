import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_003 {
    public static String f(String text, String value) {
        List<Character> textList = new ArrayList<>();
        for(char c : text.toCharArray()) {
            textList.add(c);
        }
        textList.add(value.charAt(0));
        StringBuilder sb = new StringBuilder();
        for(char c : textList) {
            sb.append(c);
        }
        return sb.toString();
    }
    public static void main(String[] args) {
    assert(f(("bcksrut"), ("q")).equals(("bcksrutq")));
    }

}
