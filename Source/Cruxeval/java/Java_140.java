import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_140 {
    public static String f(String st) {
        int lastHIndex = st.toLowerCase().lastIndexOf('h');
        int lastIAfterHIndex = st.toLowerCase().lastIndexOf('i', lastHIndex - 1);
        if (lastIAfterHIndex >= st.toLowerCase().lastIndexOf('i')) {
            return "Hey";
        } else {
            return "Hi";
        }
    }
    public static void main(String[] args) {
    assert(f(("Hi there")).equals(("Hey")));
    }

}
