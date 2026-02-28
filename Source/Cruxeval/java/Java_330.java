import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_330 {
    public static String f(String text) {
        StringBuilder ans = new StringBuilder();
        for (int i = 0; i < text.length(); i++) {
            char ch = text.charAt(i);
            if (Character.isDigit(ch)) {
                ans.append(ch);
            } else {
                ans.append(" ");
            }
        }
        return ans.toString();
    }
    public static void main(String[] args) {
    assert(f(("m4n2o")).equals((" 4 2 ")));
    }

}
