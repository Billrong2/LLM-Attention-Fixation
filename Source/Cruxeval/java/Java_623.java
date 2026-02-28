import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_623 {
    public static String f(String text, ArrayList<String> rules) {
        for(String rule : rules) {
            if(rule.equals("@")) {
                text = new StringBuilder(text).reverse().toString();
            } else if(rule.equals("~")) {
                text = text.toUpperCase();
            } else if(!text.isEmpty() && text.charAt(text.length() - 1) == rule.charAt(0)) {
                text = text.substring(0, text.length() - 1);
            }
        }
        return text;
    }
    public static void main(String[] args) {
    assert(f(("hi~!"), (new ArrayList<String>(Arrays.asList((String)"~", (String)"`", (String)"!", (String)"&")))).equals(("HI~")));
    }

}
