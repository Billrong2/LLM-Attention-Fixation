import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_559 {
    public static String f(String n) {
        n = n;
        return n.charAt(0) + "." + n.substring(1).replace("-", "_");
    }
    public static void main(String[] args) {
    assert(f(("first-second-third")).equals(("f.irst_second_third")));
    }

}
