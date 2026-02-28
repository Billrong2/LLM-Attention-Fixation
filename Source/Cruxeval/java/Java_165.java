import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_165 {
    public static boolean f(String text, long lower, long upper) {
        return text.substring((int)lower, (int)upper).chars().allMatch(Character::isLetterOrDigit);
    }
    public static void main(String[] args) {
    assert(f(("=xtanp|sugv?z"), (3l), (6l)) == (true));
    }

}
