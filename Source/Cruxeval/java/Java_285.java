import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_285 {
    public static long f(String text, String ch) {
        return text.length() - text.replace(ch, "").length();
    }
    public static void main(String[] args) {
    assert(f(("This be Pirate's Speak for 'help'!"), (" ")) == (5l));
    }

}
