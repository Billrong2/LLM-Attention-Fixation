import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_731 {
    public static String f(String text, String use) {
        return text.replace(use, "");
    }
    public static void main(String[] args) {
    assert(f(("Chris requires a ride to the airport on Friday."), ("a")).equals(("Chris requires  ride to the irport on Fridy.")));
    }

}
