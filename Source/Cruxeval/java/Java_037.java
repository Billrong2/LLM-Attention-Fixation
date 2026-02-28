import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_037 {
    public static ArrayList<String> f(String text) {
        ArrayList<String> textArr = new ArrayList<>();
        for (int j = 0; j < text.length(); j++) {
            textArr.add(text.substring(j));
        }
        return textArr;
    }
    public static void main(String[] args) {
    assert(f(("123")).equals((new ArrayList<String>(Arrays.asList((String)"123", (String)"23", (String)"3")))));
    }

}
