import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_796 {
    public static String f(String str, String toget) {
        if (str.startsWith(toget)) {
            return str.substring(toget.length());
        } else {
            return str;
        }
    }
    public static void main(String[] args) {
    assert(f(("fnuiyh"), ("ni")).equals(("fnuiyh")));
    }

}
