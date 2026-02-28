import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_474 {
    public static String f(String txt, long marker) {
        String[] lines = txt.split("\n");
        StringBuilder result = new StringBuilder();
        for (String line : lines) {
            result.append(String.format("%" + marker + "s", line)).append("\n");
        }
        return result.toString().trim();
    }
    public static void main(String[] args) {
    assert(f(("#[)[]>[^e>\n 8"), (-5l)).equals(("#[)[]>[^e>\n 8")));
    }

}
