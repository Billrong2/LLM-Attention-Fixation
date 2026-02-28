import java.io.*;
import java.lang.reflect.*;
import java.math.*;
import java.security.*;
import java.util.*;
import java.util.stream.*;
import org.javatuples.*;
import java.util.*;

class Java_580 {
    public static ArrayList<Long> f(String text, String character) {
        ArrayList<Long> a = new ArrayList<>();
        String new_text = text;
        while (new_text.contains(character)) {
            a.add((long)new_text.indexOf(character));
            new_text = new_text.replaceFirst(character, "");
        }
        return a;
    }
    public static void main(String[] args) {
    assert(f(("rvr"), ("r")).equals((new ArrayList<Long>(Arrays.asList((long)0l, (long)1l)))));
    }

}
