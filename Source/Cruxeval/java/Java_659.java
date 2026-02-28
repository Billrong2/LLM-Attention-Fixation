import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_659 {
    public static long f(ArrayList<String> bots) {
        List<String> clean = new ArrayList<>();
        for (String username : bots) {
            if (!username.equals(username.toUpperCase())) {
                clean.add(username.substring(0, 2) + username.substring(username.length() - 3));
            }
        }
        return clean.size();
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<String>(Arrays.asList((String)"yR?TAJhIW?n", (String)"o11BgEFDfoe", (String)"KnHdn2vdEd", (String)"wvwruuqfhXbGis")))) == (4l));
    }

}
