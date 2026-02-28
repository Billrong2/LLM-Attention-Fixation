import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_296 {
    public static String f(String url) {
        return url.replaceFirst("http://www.", "");
    }
    public static void main(String[] args) {
    assert(f(("https://www.www.ekapusta.com/image/url")).equals(("https://www.www.ekapusta.com/image/url")));
    }

}
