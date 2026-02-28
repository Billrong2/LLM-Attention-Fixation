import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_514 {
    public static String f(String text) {
        for (String item : text.split(" ")) {
            text = text.replace("-" + item, " ").replace(item + "-", " ");
        }
        return text.replaceAll("^-|-$", "");
    }
    public static void main(String[] args) {
    assert(f(("-stew---corn-and-beans-in soup-.-")).equals(("stew---corn-and-beans-in soup-.")));
    }

}
