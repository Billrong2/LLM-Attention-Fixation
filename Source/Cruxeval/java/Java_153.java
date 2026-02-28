import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_153 {
    public static boolean f(String text, String suffix, long num) {
        String strNum = String.valueOf(num);
        return text.endsWith(suffix + strNum);
    }
    public static void main(String[] args) {
    assert(f(("friends and love"), ("and"), (3l)) == (false));
    }

}
