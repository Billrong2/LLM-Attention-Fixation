import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_155 {
    public static String f(String ip, long n) {
        int i = 0;
        StringBuilder out = new StringBuilder();
        for (char c : ip.toCharArray()) {
            if (i == n) {
                out.append('\n');
                i = 0;
            }
            i++;
            out.append(c);
        }
        return out.toString();
    }
    public static void main(String[] args) {
    assert(f(("dskjs hjcdjnxhjicnn"), (4l)).equals(("dskj\ns hj\ncdjn\nxhji\ncnn")));
    }

}
