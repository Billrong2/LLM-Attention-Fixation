import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_228 {
    public static String f(String text, String splitter) {
        return String.join(splitter, text.toLowerCase().split("\\s+"));
    }
    public static void main(String[] args) {
    assert(f(("LlTHH sAfLAPkPhtsWP"), ("#")).equals(("llthh#saflapkphtswp")));
    }

}
