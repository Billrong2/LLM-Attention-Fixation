import java.io.*;
import java.lang.reflect.*;
import java.math.*;
import java.security.*;
import java.util.*;
import java.util.stream.*;
import org.javatuples.*;
import java.util.*;

class Java_068 {
    public static String f(String text, String pref) {
        if (text.startsWith(pref)) {
            int n = pref.length();
            String[] textAfterPref = text.substring(n).split("\\.");
            String[] textBeforePref = text.substring(0, n).split("\\.");
            List<String> resultList = new ArrayList<>();
            resultList.addAll(Arrays.asList(textAfterPref).subList(1, textAfterPref.length));
            resultList.addAll(Arrays.asList(textBeforePref).subList(0, textBeforePref.length - 1));
            text = String.join(".", resultList);
        }
        return text;
    }
    public static void main(String[] args) {
    assert(f(("omeunhwpvr.dq"), ("omeunh")).equals(("dq")));
    }

}
