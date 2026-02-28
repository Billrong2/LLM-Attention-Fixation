import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_743 {
    public static long f(String text) {
        String[] strings = text.split(",");
        return -(strings[0].length() + strings[1].length());
    }
    public static void main(String[] args) {
    assert(f(("dog,cat")) == (-6l));
    }

}
