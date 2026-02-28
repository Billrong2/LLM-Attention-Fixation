import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_280 {
    public static String f(String text) {
        String g, field;
        field = text.replace(" ", "");
        g = text.replace("0", " ");
        text = text.replace("1", "i");

        return text;
    }
    public static void main(String[] args) {
    assert(f(("00000000 00000000 01101100 01100101 01101110")).equals(("00000000 00000000 0ii0ii00 0ii00i0i 0ii0iii0")));
    }

}
