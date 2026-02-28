import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_520 {
    public static long f(ArrayList<Long> album_sales) {
        while(album_sales.size() != 1) {
            album_sales.add(album_sales.remove(0));
        }
        return album_sales.get(0).intValue();
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)6l)))) == (6l));
    }

}
