import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_565 {
    public static long f(String text) {
        return IntStream.of('a', 'e', 'i', 'o', 'u').map(ch -> text.indexOf(ch)).max().orElse(-1);
    }
    public static void main(String[] args) {
    assert(f(("qsqgijwmmhbchoj")) == (13l));
    }

}
