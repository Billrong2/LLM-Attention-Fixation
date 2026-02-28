import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_668 {
    public static String f(String text) {
        return text.charAt(text.length() - 1) + text.substring(0, text.length() - 1);
    }
    public static void main(String[] args) {
    assert(f(("hellomyfriendear")).equals(("rhellomyfriendea")));
    }

}
