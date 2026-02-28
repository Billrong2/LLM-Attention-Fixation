import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_739 {
    public static boolean f(String st, ArrayList<String> pattern) {
        for (String p : pattern) {
            if (!st.startsWith(p)) {
                return false;
            }
            st = st.substring(p.length());
        }
        return true;
    }
    public static void main(String[] args) {
    assert(f(("qwbnjrxs"), (new ArrayList<String>(Arrays.asList((String)"jr", (String)"b", (String)"r", (String)"qw")))) == (false));
    }

}
