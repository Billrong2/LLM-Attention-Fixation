import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_078 {
    public static String f(String text) {
        if (text != null && text.equals(text.toUpperCase())) {
            String result = text.toLowerCase();
            String cs = "";
            for (char c = 'A'; c <= 'Z'; c++) {
                cs += (char)(c + 32);
            }
            return result.replaceAll("[A-Z]", cs);
        }
        return text.toLowerCase().substring(0, Math.min(3, text.length()));
    }
    public static void main(String[] args) {
    assert(f(("mTYWLMwbLRVOqNEf.oLsYkZORKE[Ko[{n")).equals(("mty")));
    }

}
