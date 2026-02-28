import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_017 {
    public static long f(String text) {
        return text.indexOf(",");
    }
    public static void main(String[] args) {
    assert(f(("There are, no, commas, in this text")) == (9l));
    }

}
