import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_762 {
    public static String f(String text) {
        text = text.toLowerCase();
        String capitalize = text.substring(0, 1).toUpperCase() + text.substring(1);
        return text.substring(0, 1) + capitalize.substring(1);
    }
    public static void main(String[] args) {
    assert(f(("this And cPanel")).equals(("this and cpanel")));
    }

}
