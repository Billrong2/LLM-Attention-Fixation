import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_772 {
    public static String f(String phrase) {
        StringBuilder result = new StringBuilder();
        for (int i = 0; i < phrase.length(); i++) {
            char ch = phrase.charAt(i);
            if (!Character.isLowerCase(ch)) {
                result.append(ch);
            }
        }
        return result.toString();
    }
    public static void main(String[] args) {
    assert(f(("serjgpoDFdbcA.")).equals(("DFA.")));
    }

}
