import java.io.*;
import java.lang.reflect.*;
import java.math.*;
import java.security.*;
import java.util.*;
import java.util.stream.*;
import org.javatuples.*;
import java.util.*;

class Java_703 {
    public static String f(String text, String character) {
        int count = text.split(character + character, -1).length - 1;
        return text.substring(count);
    }
    public static void main(String[] args) {
    assert(f(("vzzv2sg"), ("z")).equals(("zzv2sg")));
    }

}
