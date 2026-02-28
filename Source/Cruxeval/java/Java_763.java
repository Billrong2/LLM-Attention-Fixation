import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_763 {
    public static String f(String values, String text, String markers) {
        return text.replaceAll("[" + values + markers + "]+$", "");
    }
    public static void main(String[] args) {
    assert(f(("2Pn"), ("yCxpg2C2Pny2"), ("")).equals(("yCxpg2C2Pny")));
    }

}
