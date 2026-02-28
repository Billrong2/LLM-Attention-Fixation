import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_331 {
    public static long f(String strand, String zmnc) {
        int poz = strand.indexOf(zmnc);
        while (poz != -1) {
            strand = strand.substring(poz + 1);
            poz = strand.indexOf(zmnc);
        }
        return strand.lastIndexOf(zmnc);
    }
    public static void main(String[] args) {
    assert(f((""), ("abc")) == (-1l));
    }

}
