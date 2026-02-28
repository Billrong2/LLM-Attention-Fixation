import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_546 {
    public static String f(String text, String speaker) {
        while (text.startsWith(speaker)) {
            text = text.substring(speaker.length());
        }
        return text;
    }
    public static void main(String[] args) {
    assert(f(("[CHARRUNNERS]Do you know who the other was? [NEGMENDS]"), ("[CHARRUNNERS]")).equals(("Do you know who the other was? [NEGMENDS]")));
    }

}
