import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_765 {
    public static long f(String text) {
        return text.chars().mapToObj(c -> (char)c)
                          .filter(Character::isDigit)
                          .count();
    }
    public static void main(String[] args) {
    assert(f(("so456")) == (3l));
    }

}
