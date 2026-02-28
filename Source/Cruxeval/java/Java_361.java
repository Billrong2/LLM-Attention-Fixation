import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_361 {
    public static long f(String text) {
        return text.split(":")[0].split("#", -1).length - 1;
    }
    public static void main(String[] args) {
    assert(f(("#! : #!")) == (1l));
    }

}
