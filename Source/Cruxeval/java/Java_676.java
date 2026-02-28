import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_676 {
    public static String f(String text, long tab_size) {
        return text.replace("\t", " ".repeat((int) tab_size));
    }
    public static void main(String[] args) {
    assert(f(("a"), (100l)).equals(("a")));
    }

}
