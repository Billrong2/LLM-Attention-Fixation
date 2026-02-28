import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_241 {
    public static String f(String postcode) {
        return postcode.substring(postcode.indexOf('C'));
    }
    public static void main(String[] args) {
    assert(f(("ED20 CW")).equals(("CW")));
    }

}
