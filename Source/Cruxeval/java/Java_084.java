import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_084 {
    public static String f(String text) {
        String[] arr = text.split(" ");
        List<String> result = new ArrayList<>();
        for (String item : arr) {
            if (item.endsWith("day")) {
                item += "y";
            } else {
                item += "day";
            }
            result.add(item);
        }
        return String.join(" ", result);
    }
    public static void main(String[] args) {
    assert(f(("nwv mef ofme bdryl")).equals(("nwvday mefday ofmeday bdrylday")));
    }

}
