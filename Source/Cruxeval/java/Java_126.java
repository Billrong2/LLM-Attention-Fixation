import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_126 {
    public static String f(String text) {
        int index = text.lastIndexOf('o');
        String div = index == -1 ? "-" : text.substring(0, index);
        String div2 = index == -1 ? "-" : text.substring(index + 1);
        return index == -1 ? "-" + text : text.charAt(index) + div + text.charAt(index) + div2;
    }
    public static void main(String[] args) {
    assert(f(("kkxkxxfck")).equals(("-kkxkxxfck")));
    }

}
