import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_096 {
    public static boolean f(String text) {
        return !text.chars().anyMatch(Character::isUpperCase);
    }
    public static void main(String[] args) {
    assert(f(("lunabotics")) == (true));
    }

}
