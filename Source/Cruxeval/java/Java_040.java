import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_040 {
    public static String f(String text) {
        StringBuilder sb = new StringBuilder(text);
        sb.append("#");
        return sb.toString();
    }
    public static void main(String[] args) {
    assert(f(("the cow goes moo")).equals(("the cow goes moo#")));
    }

}
