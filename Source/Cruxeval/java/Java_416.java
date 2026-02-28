import java.io.*;
import java.lang.reflect.*;
import java.math.*;
import java.security.*;
import java.util.*;
import java.util.stream.*;
import org.javatuples.*;
import java.util.*;

class Java_416 {
    public static String f(String text, String old, String replacement) {
        int index = text.lastIndexOf(old, text.indexOf(old));
        char[] result = text.toCharArray();
        while (index > 0) {
            for (int i = index; i < index + old.length(); i++) {
                result[i] = replacement.charAt(i - index);
            }
            index = text.lastIndexOf(old, index);
        }
        return new String(result);
    }
    public static void main(String[] args) {
    assert(f(("jysrhfm ojwesf xgwwdyr dlrul ymba bpq"), ("j"), ("1")).equals(("jysrhfm ojwesf xgwwdyr dlrul ymba bpq")));
    }

}
