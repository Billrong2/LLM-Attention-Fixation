import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_456 {
    public static String f(String s, long tab) {
        return s.replace("\t", " ".repeat((int) tab));
    }
    public static void main(String[] args) {
    assert(f(("Join us in Hungary"), (4l)).equals(("Join us in Hungary")));
    }

}
