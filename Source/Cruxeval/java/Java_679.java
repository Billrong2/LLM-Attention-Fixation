import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_679 {
    public static boolean f(String text) {
        if (text.equals("")) {
            return false;
        }
        char firstChar = text.charAt(0);
        if (Character.isDigit(firstChar)) {
            return false;
        }
        for (char lastChar : text.toCharArray()) {
            if ((lastChar != '_') && !Character.isJavaIdentifierPart(lastChar)) {
                return false;
            }
        }
        return true;
    }
    public static void main(String[] args) {
    assert(f(("meet")) == (true));
    }

}
