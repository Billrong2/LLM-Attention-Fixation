import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_799 {
    public static String f(String st) {
        if (st.charAt(0) == '~') {
            String e = String.format("%" + 10 + "s", st).replace(' ', '~');
            return f(e);
        } else {
            return String.format("%" + 10 + "s", st).replace(' ', 'n');
        }
    }
    public static void main(String[] args) {
    assert(f(("eqe-;ew22")).equals(("neqe-;ew22")));
    }

}
