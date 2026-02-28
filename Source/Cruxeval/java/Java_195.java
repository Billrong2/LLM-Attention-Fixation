import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_195 {
    public static String f(String text) {
        for(String p : new String[]{"acs", "asp", "scn"}) {
            text = text.replaceFirst("^" + p, "") + " ";
        }
        text = text.replaceFirst("^ ", "").replaceAll(" $", "");
        return text;
    }
    public static void main(String[] args) {
    assert(f(("ilfdoirwirmtoibsac")).equals(("ilfdoirwirmtoibsac  ")));
    }

}
