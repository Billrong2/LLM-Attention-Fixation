import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_313 {
    public static String f(String s, long l) {
        return String.format("%-" + l + "s", s).replace(' ', '=').split("=")[0];
    }
    public static void main(String[] args) {
    assert(f(("urecord"), (8l)).equals(("urecord")));
    }

}
