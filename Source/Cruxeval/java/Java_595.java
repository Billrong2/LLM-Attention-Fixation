import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_595 {
    public static String f(String text, String prefix) {
        if (text.startsWith(prefix)) {
            text = text.substring(prefix.length());
        }
        text = text.substring(0, 1).toUpperCase() + text.substring(1);
        return text;
    }
    public static void main(String[] args) {
    assert(f(("qdhstudentamxupuihbuztn"), ("jdm")).equals(("Qdhstudentamxupuihbuztn")));
    }

}
