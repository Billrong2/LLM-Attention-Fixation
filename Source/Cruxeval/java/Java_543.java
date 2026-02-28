import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_543 {
    public static String f(String item) {
        String modified = item.replace(". ", " , ").replace("&#33; ", "! ").replace(". ", "? ").replace(". ", ". ");
        return Character.toUpperCase(modified.charAt(0)) + modified.substring(1);
    }
    public static void main(String[] args) {
    assert(f((".,,,,,. منبت")).equals((".,,,,, , منبت")));
    }

}
