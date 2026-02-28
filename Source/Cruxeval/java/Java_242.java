import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_242 {
    public static String f(String book) {
        String[] a = book.split(":");
        if (a[0].split(" ")[a[0].split(" ").length - 1].equals(a[1].split(" ")[0])) {
            return f(String.join(" ", Arrays.copyOf(a[0].split(" "), a[0].split(" ").length - 1)) + " " + a[1]);
        }
        return book;
    }
    public static void main(String[] args) {
    assert(f(("udhv zcvi nhtnfyd :erwuyawa pun")).equals(("udhv zcvi nhtnfyd :erwuyawa pun")));
    }

}
