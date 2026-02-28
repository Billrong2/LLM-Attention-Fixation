import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_314 {
    public static String f(String text) {
        if (text.contains(",")) {
            int firstComma = text.indexOf(",");
            String before = text.substring(0, firstComma);
            String after = text.substring(firstComma + 1);
            return after + " " + before;
        } else {
            int firstSpace = text.indexOf(" ");
            String after = text.substring(firstSpace + 1);
            return ',' + after + " 0";
        }
    }
    public static void main(String[] args) {
    assert(f(("244, 105, -90")).equals((" 105, -90 244")));
    }

}
