import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_232 {
    public static String f(String text, String changes) {
        StringBuilder result = new StringBuilder();
        int count = 0;
        char[] changesArray = changes.toCharArray();
        for (char c : text.toCharArray()) {
            if (String.valueOf(c).contains("e")) {
                result.append(c);
            } else {
                result.append(changesArray[count % changesArray.length]);
            }
            count += (String.valueOf(c).contains("e") ? 0 : 1);
        }
        return result.toString();
    }
    public static void main(String[] args) {
    assert(f(("fssnvd"), ("yes")).equals(("yesyes")));
    }

}
