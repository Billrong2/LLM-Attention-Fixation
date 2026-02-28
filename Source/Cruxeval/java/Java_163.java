import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_163 {
    public static String f(String text, String space_symbol, long size) {
        StringBuilder spaces = new StringBuilder();
        for (int i = 0; i < size - text.length(); i++) {
            spaces.append(space_symbol);
        }
        return text + spaces.toString();
    }
    public static void main(String[] args) {
    assert(f(("w"), ("))"), (7l)).equals(("w))))))))))))")));
    }

}
