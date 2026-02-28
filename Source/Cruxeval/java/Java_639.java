import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_639 {
    public static String f(String perc, String full) {
        String reply = "";
        int i = 0;
        while (i < full.length() && i < perc.length() && perc.charAt(i) == full.charAt(i)) {
            if (perc.charAt(i) == full.charAt(i)) {
                reply += "yes ";
            } else {
                reply += "no ";
            }
            i++;
        }
        return reply;
    }
    public static void main(String[] args) {
    assert(f(("xabxfiwoexahxaxbxs"), ("xbabcabccb")).equals(("yes ")));
    }

}
