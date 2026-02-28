import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_701 {
    public static String f(String stg, ArrayList<String> tabs) {
        for (String tab : tabs) {
            while (stg.endsWith(tab)) {
                stg = stg.substring(0, stg.length() - tab.length());
            }
        }
        return stg;
    }
    public static void main(String[] args) {
    assert(f(("31849 let it!31849 pass!"), (new ArrayList<String>(Arrays.asList((String)"3", (String)"1", (String)"8", (String)" ", (String)"1", (String)"9", (String)"2", (String)"d")))).equals(("31849 let it!31849 pass!")));
    }

}
