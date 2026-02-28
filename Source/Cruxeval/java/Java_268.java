import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_268 {
    public static String f(String s, String separator) {
        if(s.contains(separator)){
            int index = s.indexOf(separator);
            String new_s = s.substring(0, index) + "/" + s.substring(index + 1);
            return new_s.replace("", " ").trim();
        }
        return null;
    }
    public static void main(String[] args) {
    assert(f(("h grateful k"), (" ")).equals(("h / g r a t e f u l   k")));
    }

}
