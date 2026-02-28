import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_539 {
    public static ArrayList<String> f(ArrayList<String> array) {
        ArrayList<String> c = array;
        ArrayList<String> arrayCopy = array;
        while (true) {
            c.add("_");
            if (c.equals(arrayCopy)) {
                arrayCopy.set(c.indexOf("_"), "");
                break;
            }
        }
        return arrayCopy;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<String>(Arrays.asList()))).equals((new ArrayList<String>(Arrays.asList((String)"")))));
    }

}
