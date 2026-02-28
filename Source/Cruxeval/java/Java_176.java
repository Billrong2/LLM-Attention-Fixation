import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_176 {
    public static String f(String text, String to_place) {
        int index = text.indexOf(to_place, 0) + 1;
        String afterPlace = text.substring(0, index);
        String beforePlace = text.substring(index);
        return afterPlace + beforePlace;
    }
    public static void main(String[] args) {
    assert(f(("some text"), ("some")).equals(("some text")));
    }

}
