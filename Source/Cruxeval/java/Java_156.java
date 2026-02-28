import java.io.*;
import java.lang.reflect.*;
import java.math.*;
import java.security.*;
import java.util.*;
import java.util.stream.*;
import org.javatuples.*;
import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_156 {
    public static String f(String text, long limit, String fillChar) {
        if (limit < text.length()) {
            return text.substring(0, (int)limit);
        }
        return String.format("%-" + limit + "s", text).replace(' ', fillChar.charAt(0));
    }
    public static void main(String[] args) {
    assert(f(("tqzym"), (5l), ("c")).equals(("tqzym")));
    }

}
