import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_555 {
    public static String f(String text, long tabstop) {
        text = text.replace("\n", "_____");
        text = text.replace("\t", " ".repeat((int)tabstop));
        text = text.replace("_____", "\n");
        return text;
    }
    public static void main(String[] args) {
    assert(f(("odes	code	well"), (2l)).equals(("odes  code  well")));
    }

}
