import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_159 {
    public static String f(String st) {
        StringBuilder swapped = new StringBuilder();
        for (int i = st.length() - 1; i >= 0; i--) {
            swapped.append(Character.toString(st.charAt(i)).toUpperCase().equals(Character.toString(st.charAt(i))) ?
                    Character.toString(st.charAt(i)).toLowerCase() : Character.toString(st.charAt(i)).toUpperCase());
        }
        return swapped.toString();
    }
    public static void main(String[] args) {
    assert(f(("RTiGM")).equals(("mgItr")));
    }

}
